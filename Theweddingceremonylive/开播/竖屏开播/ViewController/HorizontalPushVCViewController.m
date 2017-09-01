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


@interface HorizontalPushVCViewController ()<NIMNetCallManager>

@end

@implementation HorizontalPushVCViewController


#pragma mark - life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [NIMSDK sharedSDK];
    
    
}




#pragma mark - NIMNetCallManager   互动直播接口

/**
  创建互动直播间

 @param meeting  meeting.name/.../option
 @param completion callback
 */
- (void)reserveMeeting:(NIMNetCallMeeting *)meeting completion:(NIMNetCallMeetingHandler)completion{
    meeting.name = @"123";
    // todo: 完善 meeting
}

// 加入互动直播间
- (void)joinMeeting:(NIMNetCallMeeting *)meeting completion:(NIMNetCallMeetingHandler)completion{
    // todo: 修改 option
    NIMNetCallOption *option = meeting.option;
    option.enableBypassStreaming = YES;
    option.bypassStreamingUrl = @"123321";
    //option.videoCaptureParam
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
    
    
    
}





- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)leaveMeeting:(NIMNetCallMeeting *)meeting{
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
