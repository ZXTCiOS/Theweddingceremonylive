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

#define cellID_text @"text"
#define cellID_audience @"audience"

@interface HorizontalPushVCViewController ()<NIMNetCallManagerDelegate, NIMChatroomManagerDelegate, NIMChatManagerDelegate,  UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *localPreView;
@property (nonatomic, strong) ShuPingKaiboMaskView *maskview;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *lianmaiV;

@property (nonatomic, strong) NIMNetCallMeeting *meeting;
@property (nonatomic, copy)    NSString *roomid;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *pushUrl;


@property (nonatomic, strong) NSMutableArray *audiencelist;
@property (nonatomic, strong) NSMutableArray<NIMMessage *> *danmulist;

@property (nonatomic, assign) BOOL isMute;
@property (nonatomic, assign) NIMNetCallCamera camera;



@end

@implementation HorizontalPushVCViewController


#pragma mark - life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomid = @"11168034";
    self.roomName = @"xixi";
    self.pushUrl = @"rtmp://pe266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d?wsSecret=73e4d9a846fbadd56eccb1b5c90a3ab7&wsTime=1504859570";
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

- (void)dealloc{
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager removeDelegate:self];
}

- (void)setUpsth
{
    self.isMute = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.view.backgroundColor = UIColorHex(0xdfe2e6);
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager addDelegate:self];
}

#pragma mark - mask view

- (void)configMaskview{
    self.maskview = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShuPingKaiboMaskView class]) owner:nil options:nil].firstObject;
    self.maskview.tableView.delegate = self;
    self.maskview.tableView.dataSource = self;
    self.maskview.collectionView.delegate = self;
    self.maskview.collectionView.dataSource = self;
    [self registerCell];
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
#pragma mark 注册 cell
- (void)registerCell{
    // todo: 注册 cell
    [self.maskview.tableView registerClass:[DanmuCell class] forCellReuseIdentifier:cellID_text];
    [self.maskview.collectionView registerClass:[AudienceCell class] forCellWithReuseIdentifier:cellID_audience];
}

#pragma mark - 底部按钮功能
- (void)scrollviewBtnEvent{
    [self.maskview.closeBen bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.redbagBtn bk_addEventHandler:^(id sender) {
        // 红包
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.lianmaiBtn bk_addEventHandler:^(id sender) {
        // 断开连麦
        
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
        msg.from = @"昵称";
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        NSError *error;
        [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:&error];
        if (self.danmulist.count > 50){
            [self.danmulist removeFirstObject];
        }
        [self.danmulist addObject:msg];
        [self.maskview.tableView reloadData];
        if (self.danmulist.count > 5) [self.maskview.tableView scrollToBottom];
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

#pragma mark - 键盘弹出隐藏通知
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
# pragma mark - 观众列表 delegate DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.audiencelist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AudienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID_audience forIndexPath:indexPath];
    // tofix
    [cell.img sd_setImageWithURL:self.audiencelist[indexPath.row] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 点击头像, 连麦, 给房管
}
#pragma mark - 观众列表 flowlayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

#pragma mark - tableview delegate && datasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.danmulist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID_text forIndexPath:indexPath];
    cell.textL.text = self.danmulist[indexPath.row].text;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 主播, 管理员踢人封禁操作  view
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark - 聊天室

- (void)enterChatroom{
    
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId = self.roomid;
    request.roomExt = @"ext";
    request.roomNotifyExt = @"";
    request.retryCount = 5;
    [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom, NIMChatroomMember * _Nullable me) {
        NSLog(@"进入聊天室成功 roomID: %@", chatroom.roomId);
    }];
}

// 收到聊天室消息
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    NSInteger remove = self.danmulist.count + messages.count - 50;
    for (int i = 0; i < remove; i++) {
        [self.danmulist removeFirstObject];
    }
    [self.danmulist addObjectsFromArray:messages];
    [self.maskview.tableView reloadData];
    if (self.danmulist.count > 5) [self.maskview.tableView scrollToBottom];
}

- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    
    if (error) {
        NSError *err;
        [[NIMSDK sharedSDK].chatManager resendMessage:message error:&err];
        //NSLog(@"error %@", error);
    } else {
        NSLog(@"message %@", message);
    }
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
    self.meeting.name = self.roomName;//[userDefault objectForKey:user_uid]; // 使用 UID 作为互动直播间 name.
    [[NIMAVChatSDK sharedSDK].netCallManager reserveMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        NSLog(@" reserve meeting error %@", error);
        //if (!error) NSLog(@"-------创建 metting 成功------  meeting: %@", meeting);
    }];
}


// 加入互动直播间
- (void)joinMeeting{
    
    // todo: 修改 option
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    self.meeting.option = option;
    option.enableBypassStreaming = YES;
    option.bypassStreamingUrl = self.pushUrl;
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
    option.bypassStreamingVideoMixMode = NIMNetCallVideoMixModeCustomLayout;
    option.bypassStreamingVideoMixCustomLayoutConfig = @"{\"version\":0,\"set_host_as_main\":true,\"host_area\":{\"adaption\":1},\"special_show_mode\":true,\"n_host_area_number\":1,\"n_host_area_0\":{\"position_x\":0,\"position_y\":0,\"width_rate\":10000,\"height_rate\":10000,\"adaption\":0}}";
    self.meeting.actor = YES;
    
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        [[NIMAVChatSDK sharedSDK].netCallManager setSpeaker:YES];
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

//本地摄像头预览就绪回调


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
    
    
    NSLog(@"uid: %@ 加入", uid);
}

// 用户离开房间通知
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    NSLog(@"uid: %@ 离开", uid);
    self.lianmaiV.hidden = YES;
    self.lianmaiV = nil;
}

// 房间错误通知
- (void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting{
    // 一些异常情况可能会引起房间出错，请在收到该回调以后主动离开房间。
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:meeting];
}

// 直播状态回调
- (void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code{
    
}

// 远程视频 YUV 数据就绪
- (void)onRemoteYUVReady:(NSData *)yuvData width:(NSUInteger)width height:(NSUInteger)height from:(NSString *)user{
    UIImage *img = [UIImage imageWithData:yuvData];
    self.lianmaiV.image = img;
}

- (void)onRemoteImageReady:(CGImageRef)image{
    
}
#pragma mark - 懒加载

- (NSMutableArray *)audiencelist{
    if (!_audiencelist) {
        _audiencelist = [NSMutableArray array];
    }
    return _audiencelist;
}

- (NSMutableArray<NIMMessage *> *)danmulist{
    if (!_danmulist) {
        _danmulist = [NSMutableArray<NIMMessage *> array];
    }
    return _danmulist;
}

- (UIImageView *)lianmaiV{
    if (!_lianmaiV) {
        _lianmaiV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        //_lianmaiV.hidden = YES;
        [self.view insertSubview:_lianmaiV aboveSubview:self.displayView];
    }
    return _lianmaiV;
}



#pragma mark - receiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
