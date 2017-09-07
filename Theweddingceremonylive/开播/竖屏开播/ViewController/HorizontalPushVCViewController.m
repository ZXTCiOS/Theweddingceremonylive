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

// model

// view

// viewcontroller


@interface HorizontalPushVCViewController ()<NIMNetCallManagerDelegate>

@property (nonatomic, strong) UIView *localPreView;

@property (nonatomic, strong) NIMNetCallMeeting *meeting;

@property (nonatomic, strong) UIView *displayView;

@property (nonatomic, copy)   NIMChatroom *chatroom;







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
    
    // 创建群组
    NIMCreateTeamOption *option = [[NIMCreateTeamOption alloc] init];
    //[NIMSDK sharedSDK].teamManager createTeam: option users:<#(nonnull NSArray<NSString *> *)#> completion:<#^(NSError * _Nullable error, NSString * _Nullable teamId)completion#>
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
}


- (void)setUpsth
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.view.backgroundColor = UIColorHex(0xdfe2e6);
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
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
    option.bypassStreamingUrl = @"rtmp://pe266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d?wsSecret=79238f1d3d3c7f3de0fb1870fcc5f23d&wsTime=1504668103";
     option.videoCaptureParam = [self para];
    // 开启该选项，以在远端设备旋转时在本端自动调整角度
    option.autoRotateRemoteVideo = YES;
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
    /**
     混屏模式:
     右侧纵排浮窗
     左侧纵排浮窗；
     四分格平铺；
     四分格裁剪平铺。
     */
    option.bypassStreamingVideoMixMode = 0;
    
    /**
     混屏自定义布局
     */
    //option.bypassStreamingVideoMixCustomLayoutConfig
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
    para.startWithBackCamera = NO;
    para.startWithCameraOn = YES;
    /*
     *  默认方向
    NIMVideoOrientationDefault             = 0,
     *  垂直方向, home 键朝下
     
    NIMVideoOrientationPortrait            = 1,
     *  垂直方向, home 键朝上
    NIMVideoOrientationPortraitUpsideDown  = 2,
     *  平方向, home 键在右边
    NIMVideoOrientationLandscapeRight      = 3,
     *  水平方向, home 键在左边
    NIMVideoOrientationLandscapeLeft       = 4,
     */
    para.videoCaptureOrientation = 0;
    //para.videoCrop //裁剪16:9, 4:3, 1:1;
    MJWeakSelf
    para.videoHandler = ^(CMSampleBufferRef sampleBuffer){
        [weakSelf processVideoSampleBuffer:sampleBuffer];
    };
    return para;
}

- (void)processVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    size_t bufferWidth = 0;
    size_t bufferHeight = 0;
    
    if (CVPixelBufferIsPlanar(pixelBuffer)) {
        bufferHeight = CVPixelBufferGetHeightOfPlane(pixelBuffer, 0);
        bufferWidth = CVPixelBufferGetWidthOfPlane(pixelBuffer, 0);
    } else {
        bufferWidth = CVPixelBufferGetWidth(pixelBuffer);
        bufferHeight = CVPixelBufferGetHeight(pixelBuffer);
    }
    /*
    if ([NTESLiveManager sharedInstance].orientation == NIMVideoOrientationLandscapeRight) {
        if (bufferWidth < bufferHeight) {
            NSLog(@"============== bufferWidth < bufferHeight");
            return;
        }
    }*/
    
    [[NIMAVChatSDK sharedSDK].netCallManager sendVideoSampleBuffer:sampleBuffer];
    // 水印
    //[[NIMAVChatSDK sharedSDK].netCallManager addWaterMark:[UIImage imageNamed:@"uiimage"] rect:CGRectMake(0, 0, 0, 0) location:0];
    // 清除水印
    //[[NIMAVChatSDK sharedSDK].netCallManager cleanWaterMark];
}


#pragma mark  - NIMNetCallManagerDelegate

// 获取摄像头画面成功回调
- (void)onLocalDisplayviewReady:(UIView *)displayView{
    
    if (self.displayView) {
        [self.displayView removeFromSuperview];
    }
    self.displayView = displayView;
    self.displayView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [self.view addSubview:self.displayView];
    
    // 默认美颜自然模式
    [[NIMAVChatSDK sharedSDK].netCallManager selectBeautifyType:NIMNetCallFilterTypeZiran];
}

/*
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

#pragma mark - 视频采集开始以后的动态控制

// 动态设置视频采集方向
- (BOOL)setVideoCaptureOrientation:(NIMVideoOrientation)orientation{
    //orientation =
    return YES;
}

// 采集方向切换完成后，SDK 通过以下回调通知应用：
- (void)onCameraOrientationSwitchCompleted:(NIMVideoOrientation)orientation{
    
}

//动态设置摄像头开关：
- (BOOL)setCameraDisable:(BOOL)disable{
    disable = !disable;
    return YES;
}

//动态切换前后摄像头：
- (void)switchCamera:(NIMNetCallCamera)camera{
    
}

//摄像头切换完成后，SDK 通过以下回调通知应用：
- (void)onCameraTypeSwitchCompleted:(NIMNetCallCamera)cameraType{
    
}

//动态切换采集清晰度：
- (BOOL)switchVideoQuality:(NIMNetCallVideoQuality)quality{
    
    return YES;
}

//清晰度切换完成后，SDK 通过以下回调通知应用：
- (void)onCameraQualitySwitchCompleted:(NIMNetCallVideoQuality)videoQuality{
    
}

//动态开关闪光灯：
- (void)setCameraFlash:(BOOL)isFlashOn{
    
}

//动态调节摄像头焦距，对画面进行放大缩小：
- (void)changeLensPosition:(float)scale{
    
}

//通过以下接口来获取摄像头最大放大倍数：
- (CGFloat)getMaxZoomScale{
    return 1;
}

//动态切换对焦模式：
- (void)setFocusMode:(NIMNetCallFocusMode)mode{
    
}

//当切换为手动对焦后，使用以下接口来传入对焦点，进行对焦：
- (void)changeNMCVideoPreViewManualFocusPoint:(CGPoint)devicePoint{
    
}



#pragma mark - 通话过程控制


//设置静音...静音后对端将听不到本端的声音。
- (BOOL)setMute:(BOOL)mute{
    
    return YES;
}

//设置扬声器...用于在扬声器和听筒间切换。
- (BOOL)setSpeaker:(BOOL)useSpeaker{
    
    return YES;
}

//切换通话模式
- (void)switchType:(NIMNetCallMediaType)type{
    
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


*/


#pragma mark - 创建群组










#pragma mark - receiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
