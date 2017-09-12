//
//  PortraitFullViewController.m
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import "PortraitFullViewController.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import <IQKeyboardManager.h>

// model

// view
#import "PortraitFullMaskView.h"
#import "AudienceCell.h"
#import "DanmuCell.h"

// viewcontroller
#import "NELivePlayerController.h"// 网易云播放器
#import "NELivePlayer.h"// 网易云播放器协议


#define urls @"rtmp://ve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d" // rtmp


#define cellID_text @"text"
#define cellID_audience @"audience"

@interface PortraitFullViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, NIMChatroomManagerDelegate, NIMChatManagerDelegate, NIMNetCallManagerDelegate>


@property (nonatomic, strong) UIScrollView *scrollV;               // 遮罩层
@property (nonatomic, strong) PortraitFullMaskView *maskview;
@property (nonatomic) UIImageView *placeholderView;                 // 模糊图片
@property (nonatomic, strong) UIView *displayView;


@property(nonatomic, strong) id<NELivePlayer> liveplayer;           // 网易云播放器
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *roomid;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, assign) NIMNetCallCamera camera;
@property (nonatomic, strong) NIMNetCallMeeting *meeting;


@property (nonatomic, strong) UITableView *tableView;           // 聊天框
@property (nonatomic, strong) UICollectionView *collectionView;   // 观众 view

@property (nonatomic, strong) NSMutableArray *audiencelist;
@property (nonatomic, strong) NSMutableArray<NIMMessage *> *danmulist;

@end

@implementation PortraitFullViewController

#pragma mark - life cycle  生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.roomid = @"11168034";
    self.roomName = @"xixi";
    [self setup];
    [self liveplayer];
    [self placeholderView];
    [self configMaskview];
    [self addNotification];
    [self enterChatroom];
    
}

- (void)setup{
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager addDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.liveplayer setBufferStrategy:NELPLowDelay];
    [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
    [self.liveplayer setShouldAutoplay:YES];
    [self.liveplayer setPauseInBackground:NO];
    [self.liveplayer setPlaybackTimeout:15 *1000];
    [self.liveplayer prepareToPlay];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //关闭键盘相应
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowshow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidehide:) name: UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.liveplayer shutdown];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    NSLog(@"protraitFullViewController dealloc");
    // 退出聊天室
    [[NIMSDK sharedSDK].chatroomManager exitChatroom:self.roomid completion:^(NSError * _Nullable error) {
        NSLog(@"退出聊天室 error %@", error);
    }];
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerDidPreparedToPlayNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerLoadStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackFinishedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstVideoDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstAudioDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerVideoParseErrorNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerMoviePlayerSeekCompletedNotification object:_liveplayer];
    
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager removeDelegate:self];
}





- (void)configPlayer{
    
    self.liveplayer = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:urls]];
    if (self.liveplayer == nil) {
        NSLog(@"failed to initialize!");
    }
    UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.liveplayer.view.frame = playerView.bounds;
    [self.liveplayer prepareToPlay];
    self.liveplayer.shouldAutoplay = YES;
    [self.view addSubview:self.liveplayer.view];
    [self.liveplayer play];
}



#pragma mark - 设置 view

- (void)configMaskview{
    
    self.maskview = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PortraitFullMaskView class]) owner:nil options:nil].firstObject;
    self.maskview.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
    [self.maskview.user_img sd_setImageWithURL:@"http://liveimg.9158.com/pic/avator/2017-08/14/23/20170814230649_63538231_250.png".xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.maskview.user_name.text = @"美味🍦静静";
    self.maskview.user_id.text = @"id:1231123";
    self.maskview.countL.text = @"123321";
    [self configBottomBtn:self.maskview];
    self.maskview.textField.inputAccessoryView = [UIView new];
    self.maskview.tableView.tableFooterView = [UIView new];
    self.maskview.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = self.maskview.tableView;
    self.collectionView = self.maskview.collectionView;
    [self registerCell];
    [self shareBtnClick];
    self.maskview.tableView.delegate = self;
    self.maskview.tableView.dataSource = self;
    self.maskview.collectionView.delegate = self;
    self.maskview.collectionView.dataSource = self;
    [self.scrollV addSubview:self.maskview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark - 分享
- (void)shareBtnClick{
    // TODO: 添加分享功能
    [self.maskview.QQ bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.Wechat bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.Pengyouquan bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 注册 cell
- (void)registerCell{
    // todo: 注册 cell
    [self.tableView registerClass:[DanmuCell class] forCellReuseIdentifier:cellID_text];
    [self.collectionView registerClass:[AudienceCell class] forCellWithReuseIdentifier:cellID_audience];
}

- (void)configBottomBtn:(PortraitFullMaskView *)view{
    view.first = ^(){//聊天
        [self.maskview.textField becomeFirstResponder];
    };
    view.second = ^(){//连麦 红包
        [self joinLianmai];
    };
    view.third = ^(){//礼物
        NSLog(@"3");
    };
    view.fourth = ^(){//分享
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH - 110, kScreenW, 110);
        }];
    };
    view.fifth = ^(){//返回
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.maskview.send bk_addEventHandler:^(id sender) {
        // 发送文字消息
        NSString *text = self.maskview.textField.text;
        NIMMessage *msg = [[NIMMessage alloc] init];
        msg.text = text;
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:nil];
        if (self.danmulist.count > 50){
            [self.danmulist removeFirstObject];
        }
        [self.danmulist addObject:msg];
        [self.tableView reloadData];
        if (self.danmulist.count > 5) [self.tableView scrollToBottom];
        self.maskview.textField.text = @"";
        [self.maskview.textField resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    view.icon = ^(){//个人资料
        
        
    };
    [view.leaveMeeting bk_addEventHandler:^(id sender) {
        // 连麦者主动离开直播间
        [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
        [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
        self.displayView = nil;
        [self.liveplayer switchContentUrl:[NSURL URLWithString:self.url]];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 收到连麦消息  点击同意
- (void)joinLianmai{
    // 打开摄像头
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    [self joinMeeting];
    [self.liveplayer stop];
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
        [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
        //if (!error) NSLog(@"-------加入 metting 成功------  meeting: %@", meeting);
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

#pragma mark - 聊天室 delegate && datasourse
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
        if (!error) NSLog(@"进入聊天室成功");
    }];
}

// 发送消息回调
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    if (error) {
        NSError *err;
        [[NIMSDK sharedSDK].chatManager resendMessage:message error:&err];
        NSLog(@"error %@", error);
    } else {
        //NSLog(@"message %@", message);
    }
}

// 收到聊天室消息
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    NSInteger remove = self.danmulist.count + messages.count - 50;
    for (int i = 0; i < remove; i++) {
        [self.danmulist removeFirstObject];
    }
    [self.danmulist addObjectsFromArray:messages];
    [self.tableView reloadData];
    if (self.danmulist.count > 5) [self.tableView scrollToBottom];
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


#pragma mark - lazy loading  懒加载

- (id<NELivePlayer>)liveplayer{
    if (!_liveplayer) {
        _liveplayer = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:urls]];
        if (!_liveplayer) {
            NSLog(@"播放器初始化失败");
        }
        UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _liveplayer.view.frame = playerView.bounds;
        [_liveplayer prepareToPlay];
        _liveplayer.shouldAutoplay = YES;
        [self.view addSubview:_liveplayer.view];
        [_liveplayer play];
    }
    return _liveplayer;
}

- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scrollV.contentSize = CGSizeMake(kScreenW*2, kScreenH);
        _scrollV.contentOffset = CGPointMake(kScreenW, 0);
        _scrollV.pagingEnabled = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.bounces = NO;
        [self.view addSubview:_scrollV];
    }
    return _scrollV;
}

- (UIImageView *)placeholderView {
    if(_placeholderView == nil) {
        _placeholderView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        //[_placeholderView setImageURL:@"".xd_URL];
        _placeholderView.image = [UIImage imageNamed:@"qidong"];
        _placeholderView.contentMode = UIViewContentModeScaleAspectFill;
        _placeholderView.clipsToBounds = YES;
        //模糊效果
        UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:blur];
        view.frame = _placeholderView.bounds;
        [_placeholderView addSubview:view];
        [self.view addSubview:_placeholderView];
        [self.view sendSubviewToBack:_placeholderView];
    }
    return _placeholderView;
}



- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_liveplayer];
}

- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    //add some methods
    NSLog(@"NELivePlayerDidPreparedToPlay");
    //[self syncUIStatus];
    [self.liveplayer play]; //开始播放
}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification
{
    //    NSLog(@"NELivePlayerPlaybackStateChanged");
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification
{
    NELPMovieLoadState nelpLoadState = _liveplayer.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
//        self.bufferingIndicate.hidden = YES;
//        self.bufferingReminder.hidden = YES;
//        [self.bufferingIndicate stopAnimating];
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
//        self.bufferingIndicate.hidden = NO;
//        self.bufferingReminder.hidden = NO;
//        [self.bufferingIndicate startAnimating];
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification
{
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
        {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if (self.presentingViewController) {
                        
                    }}];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                [self.liveplayer switchContentUrl:[NSURL URLWithString:urls]];
                [self.liveplayer prepareToPlay];
                [self.liveplayer play];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification
{
    NSLog(@"first video frame rendered!");
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification
{
    NSLog(@"first audio frame rendered!");
}

- (void)NELivePlayerVideoParseError:(NSNotification*)notification
{
    NSLog(@"video parse error!");
}

- (void)NELivePlayerSeekComplete:(NSNotification*)notification
{
    NSLog(@"seek complete!");
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification
{
    NSLog(@"resource release success!!!");
    // 释放timer
//    if (timer != nil) {
//        dispatch_source_cancel(timer);
//        timer = nil;
//    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerReleaseSueecssNotification object:_liveplayer];
}

#pragma mark 懒加载

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

#pragma mark - initialize 初始化

- (instancetype)initWithChatroomID:(NSString *)roomid Url:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
        self.roomid = roomid;
    }
    return self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
