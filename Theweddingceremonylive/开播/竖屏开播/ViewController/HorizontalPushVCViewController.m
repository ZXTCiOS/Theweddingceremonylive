//
//  HorizontalPushVCViewController.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HorizontalPushVCViewController.h"
// function
#import <NIMSDK/NIMSDK.h>// 网易互动直播头文件
#import <NIMAVChat/NIMAVChat.h>
#import <IQKeyboardManager.h>
// model

// view
#import "ShuPingKaiboMaskView.h"
#import "AudienceCell.h"
#import "DanmuCell.h"

// viewcontroller


@interface HorizontalPushVCViewController ()<NIMNetCallManagerDelegate, NIMChatroomManagerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *localPreView;
@property (nonatomic, strong) ShuPingKaiboMaskView *maskview;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) UIScrollView *scrollV;

@property (nonatomic, strong) NIMNetCallMeeting *meeting;
@property (nonatomic, copy)    NSString *roomid;

@property (nonatomic, strong) NSMutableArray *audiencelist;
@property (nonatomic, strong) NSMutableArray *danmulist;

@property (nonatomic, assign) BOOL isMute;
@property (nonatomic, assign) NIMNetCallCamera camera;



@end

@implementation HorizontalPushVCViewController


#pragma mark - life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpsth];
    // 创建直播间
    [self reserveMeeting];
    // 加入直播间
    [self joinMeeting];
    // 打开摄像头预览
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    // 进入聊天室
    [self enterChatroom];
    // mask view
    [self configMaskview];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //关闭键盘相应
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowshow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidehide:) name: UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
    [[NIMSDK sharedSDK].chatroomManager exitChatroom:self.roomid completion:^(NSError * _Nullable error) {
        
    }];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)setUpsth
{
    self.isMute = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.view.backgroundColor = UIColorHex(0xdfe2e6);
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
}

#pragma mark - mask view

- (void)configMaskview{
    self.maskview = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShuPingKaiboMaskView class]) owner:nil options:nil].firstObject;
    self.maskview.tableView.delegate = self;
    self.maskview.tableView.dataSource = self;
    self.maskview.collectionView.delegate = self;
    self.maskview.collectionView.dataSource = self;
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _scrollV.contentSize = CGSizeMake(kScreenW*2, kScreenH);
    _scrollV.contentOffset = CGPointMake(kScreenW, 0);
    _scrollV.bounces = NO;
    _scrollV.pagingEnabled = YES;
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.showsVerticalScrollIndicator = NO;
    [self scrollviewBtnEvent];
    self.maskview.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
    self.maskview.textField.inputAccessoryView = [UIView new];
    [self.scrollV addSubview:self.maskview];
    [self.view insertSubview:_scrollV atIndex:0];
}

- (void)scrollviewBtnEvent{
    [self.maskview.closeBen bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.redbagBtn bk_addEventHandler:^(id sender) {
        // 红包
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.lianmaiBtn bk_addEventHandler:^(id sender) {
        // 连麦
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.sendMsgBtn bk_addEventHandler:^(id sender) {
        // 弹出键盘
        [self.maskview.textField becomeFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.send bk_addEventHandler:^(id sender) {
        // 发送文字消息
        NSString *text = self.maskview.textField.text;
        NIMMessage *msg = [[NIMMessage alloc] init];
        msg.text = text;
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:nil];
        self.maskview.textField.text = @"";
        [self.maskview.textField resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.jingyinBtn bk_addEventHandler:^(id sender) {
        self.isMute = !self.isMute;
        [[NIMAVChatSDK sharedSDK].netCallManager setMute:self.isMute];
        // todo: 更改静音按钮图片
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.isBack bk_addEventHandler:^(id sender) {
        // 切换前后摄像头
        self.camera = !self.camera;
        [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:self.camera];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)keyboardWillShowshow:(NSNotification *) noti{
    
    NSDictionary *userInfo = [noti userInfo];
    //NSLog(@"userinfo: %@", userInfo);
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect frame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frame];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [self.view layoutIfNeeded];
        self.maskview.textFView.frame = CGRectMake(0, frame.origin.y - 40, kScreenW, 40);
        
    }];
}

- (void)keyboardWillHidehide:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    //NSLog(@"userinfo: %@", userInfo);
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.maskview.textFView.frame = CGRectMake(0, kScreenH, kScreenW, 40);
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.audiencelist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AudienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    // tofix
    [cell.img sd_setImageWithURL:self.audiencelist[indexPath.row] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 点击头像, 连麦, 给房管
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.danmulist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"danmu" forIndexPath:indexPath];
    cell.textL.text = @"富文本";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 主播, 管理员踢人封禁操作  view
}



#pragma mark - 聊天室

- (void)enterChatroom{
    
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId = @"11168034";//self.roomid;
    request.roomExt = @"ext";
    request.roomNotifyExt = @"";
    request.retryCount = 5;
    [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom, NIMChatroomMember * _Nullable me) {
        NSLog(@"进入聊天室成功 roomID: %@", chatroom.roomId);
    }];
}

// 聊天室连接状态
- (void)chatroom:(NSString *)roomId connectionStateChanged:(NIMChatroomConnectionState)state{
    
    NSLog(@"state: %ld", state);
}
// 自动登录失败
- (void)chatroom:(NSString *)roomId autoLoginFailed:(NSError *)error{
    
}
// 聊天室关闭, 或者被踢
- (void)chatroom:(NSString *)roomId beKicked:(NIMChatroomKickReason)reason{
    
}

#pragma mark - NIMNetCallManager   互动直播接口

// 创建直播间
- (void)reserveMeeting{
    self.meeting = [[NIMNetCallMeeting alloc] init];
    self.meeting.name = @"xixi";//[userDefault objectForKey:user_uid]; // 使用 UID 作为互动直播间 name.
    [[NIMAVChatSDK sharedSDK].netCallManager reserveMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        NSLog(@" reserve meeting error %@", error);
        if (!error) NSLog(@"-------创建 metting 成功------  meeting: %@", meeting);
    }];
}


// 加入互动直播间
- (void)joinMeeting{
    
    // todo: 修改 option
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    self.meeting.option = option;
    option.enableBypassStreaming = YES;
    option.bypassStreamingUrl = @"rtmp://pe266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d?wsSecret=73e4d9a846fbadd56eccb1b5c90a3ab7&wsTime=1504859570";
     option.videoCaptureParam = [self para];
    // 开启该选项，以在远端设备旋转时在本端自动调整角度
    option.autoRotateRemoteVideo = NO;
    // 编码器
    option.preferredVideoEncoder = NIMNetCallVideoCodecDefault;
    // 解码器
    option.preferredVideoDecoder = NIMNetCallVideoCodecDefault;
    // 最大编码 码率 不指定自动选择
    //option.videoMaxEncodeBitrate
    // 语音降噪
    option.audioDenoise = YES;
    // 人声检测
    option.voiceDetect = NO;
    // 服务器录制视频
    option.serverRecordVideo = YES;
    // 服务器录制音频
    option.serverRecordAudio = YES;
    // 服务器录制
    option.bypassStreamingServerRecording = YES;
    // 扩展消息
    option.extendMessage = @"扩展消息";
    
    option.bypassStreamingVideoMixMode = 0;//NIMNetCallVideoMixModeCustomLayout;
    //option.bypassStreamingVideoMixCustomLayoutConfig = @"";
    self.meeting.actor = YES;
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        NSLog(@"join error %@", error);
        if (!error) NSLog(@"-------加入 metting 成功------  meeting: %@", meeting);
    }];
}


// 配置视频采集参数
- (NIMNetCallVideoCaptureParam *)para{
    NIMNetCallVideoCaptureParam *para = [[NIMNetCallVideoCaptureParam alloc] init];
    para.format = 0;
    //默认是否是后置摄像头
    para.startWithBackCamera = YES;
    self.camera = NIMNetCallCameraBack;
    para.startWithCameraOn = YES;
    para.videoCaptureOrientation = 0;
    
    return para;
}


#pragma mark  - NIMNetCallManagerDelegate

// 获取摄像头画面成功回调
- (void)onLocalDisplayviewReady:(UIView *)displayView{
    
    if (self.displayView) {
        [self.displayView removeFromSuperview];
    }
    self.displayView = displayView;
    self.displayView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [self.view insertSubview:self.displayView belowSubview:self.scrollV];
    // 默认美颜自然模式
    [[NIMAVChatSDK sharedSDK].netCallManager selectBeautifyType:NIMNetCallFilterTypeZiran];
}


// 用户加入房间通知
- (void)onUserJoined:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    
}

// 用户离开房间通知
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    
}

// 房间错误通知
- (void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting{
    // 一些异常情况可能会引起房间出错，请在收到该回调以后主动离开房间。
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:meeting];
}

// 直播状态回调
- (void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code{
    
}




#pragma mark - 通话中的编解码控制

//设置视频最大编码码率
- (BOOL)setVideoMaxEncodeBitrate:(NSUInteger)bitrate{
    
    return YES;
}
//可以在视频通话过程中实时改变视频编码码率，以满足不同网络状况和使用场景需求。如果用户尚未加入通话，则无法设置。

//切换视频编解码器
- (BOOL)switchVideoEncoder:(NIMNetCallVideoCodec)codec{
    
    return YES;
}
- (BOOL)switchVideoDecoder:(NIMNetCallVideoCodec)codec{
    
    return YES;
}
//可以在视频通话过程中实时切换软硬件编解码器。硬件编解码设置仅在 iOS 8.0 及以上系统有效。如果用户尚未加入通话，则无法设置。








#pragma mark - lazy loading

- (NSMutableArray *)audiencelist{
    if (!_audiencelist) {
        _audiencelist = [NSMutableArray array];
    }
    return _audiencelist;
}

- (NSMutableArray *)danmulist{
    if (!_danmulist) {
        _danmulist = [NSMutableArray array];
    }
    return _danmulist;
}





#pragma mark - receiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
