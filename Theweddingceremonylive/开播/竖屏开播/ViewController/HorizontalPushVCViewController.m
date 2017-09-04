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


@interface HorizontalPushVCViewController ()<NIMNetCallManager, NIMNetCallManagerDelegate>

@property (nonatomic, strong) UIView *localPreView;

@property (nonatomic, strong) NIMNetCallMeeting *meeting;

@property (nonatomic, strong) UIView *displayView;

@property (nonatomic, copy)   NIMChatroom *chatroom;







@end

@implementation HorizontalPushVCViewController


#pragma mark - life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpsth];
    
    
    
    [self reserveMeeting];
    [self joinMeeting];
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    
    
    
    
    
    
}

- (void)setUpsth
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.view.backgroundColor = UIColorHex(0xdfe2e6);
    
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
}





#pragma mark - NIMNetCallManager   互动直播接口

// 创建直播间
- (void)reserveMeeting{
    self.meeting = [[NIMNetCallMeeting alloc] init];
    self.meeting.name = @"123";
    [[NIMAVChatSDK sharedSDK].netCallManager reserveMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        if (!error) NSLog(@"-------创建 metting 成功------  meeting: %@", meeting);
    }];
}

// 加入互动直播间
- (void)joinMeeting{
    
    // todo: 修改 option
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    self.meeting.option = option;
    option.enableBypassStreaming = YES;
    option.bypassStreamingUrl = @"rtmp://pe266c7be.live.126.net/live/1bf06ff07806476a8485c4811581110d?wsSecret=db7a64442ca9837b715cd79582ac1c64&wsTime=1504523581 ";
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
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
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
    
}


#pragma mark  - NIMNetCallManagerDelegate

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










// 用户加入房间
- (void)onUserJoined:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    
}

// 用户离开房间
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    
}

// 房间错误
- (void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting{
    // 一些异常情况可能会引起房间出错，请在收到该回调以后主动离开房间。
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:meeting];
}

// 直播状态
- (void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code{
    
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
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
