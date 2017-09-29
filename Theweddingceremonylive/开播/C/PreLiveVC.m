//
//  PreLiveVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "PreLiveVC.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import "PreLiveView.h"
#import "HorizontalPushVCViewController.h"
#import "hengpingKaiboVC.h"


@interface PreLiveVC ()<NIMNetCallManagerDelegate>

@property (nonatomic, assign) NIMNetCallCamera camera;  // 前后摄像头
@property (nonatomic, assign) BOOL isPortrait;
@property (nonatomic, strong) PreLiveView *maskview;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *orderID;

@end

@implementation PreLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isPortrait = YES;
    self.camera = NIMNetCallCameraBack;
    
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    
//    NSString *uid = [userDefault objectForKey:user_uid];
//    NSString *token = [userDefault objectForKey:user_token];
//    [DNNetworking postWithURLString:post_zhuboInfo parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
//
//        NSString *code = [obj objectForKey:@"code"];
//        if ([code isEqualToString:@"1000"]) {
//            NSDictionary *data = [obj objectForKey:@"data"];
//            NSString *roomid = [data objectForKey:@"roomid"];
//            NSString *tuiliu = [data objectForKey:@"tuiliu"];
//            NSString *yue = [data objectForKey:@"yuer"];
//            self.pwd = [data objectForKey:@"passwork"];
//            self.type = [data objectForKey:@"leixing"];
//            self.roomid = roomid;
//            self.tuiliu = tuiliu;
//            self.yue = yue.floatValue;
//            self.orderID = [obj objectForKey:@"ordersn"];
//        }
//    } failure:^(NSError *error) {
//        [self.view showWarning:@"网络错误"];
//    }];
    
    
    [self configMaskview];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
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

- (void)configMaskview{
    
    NSString *title = self.istesting? @" 我要体验": @"开始直播";
    [self.maskview.kaishi setTitle:title forState:UIControlStateNormal];
    
    [self.maskview.switchCamera bk_addEventHandler:^(id sender) {
        self.camera = !self.camera;
        [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:self.camera];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.switchScreen bk_addEventHandler:^(id sender) {
        [self changeOrientation];
        self.isPortrait = !self.isPortrait;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.cancel bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:NO];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.kaishi bk_addEventHandler:^(id sender) {
        
        //self.type类型判断: 1.内部亲友直播:100人以内    2. 内部亲友直播:>100      3. 公开直播     4. 定制直播
        
        // 是否加密
        
        
        
        if (self.roomid && self.tuiliu) {
            
            if (self.isPortrait) {
                HorizontalPushVCViewController *vc = [[HorizontalPushVCViewController alloc] initWithChatroomID:self.roomid pushurl:self.tuiliu yue:self.yue];
                vc.type = self.type;
                vc.pwd = self.pwd;
                vc.biaoti = self.maskview.title.text;
                vc.camera = self.camera;
                vc.orderID = self.orderID;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                hengpingKaiboVC *vc = [[hengpingKaiboVC alloc] initWithChatroomID:self.roomid pushurl:self.tuiliu yue:self.yue];
                vc.type = self.type;
                vc.pwd = self.pwd;
                vc.biaoti = self.maskview.title.text;
                vc.camera = self.camera;
                vc.orderID = self.orderID;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.maskview.title.backgroundColor = krgb(0, 0, 0, 0.3);
    self.maskview.title.placeholder = @"请输入标题...";
}

- (void)changeOrientation{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
        
    } else if (orientation == UIInterfaceOrientationPortrait){
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        
    } else {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        
    }
}

#pragma mark - netcalldelegate

- (void)onLocalDisplayviewReady:(UIView *)displayView{
    if (self.displayView) {
        [self.displayView removeFromSuperview];
        self.displayView = nil;
    }
    self.displayView = displayView;
    
    [[NIMAVChatSDK sharedSDK].netCallManager selectBeautifyType:NIMNetCallFilterTypeZiran];
    [self.view insertSubview:self.displayView belowSubview:self.maskview];
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(0);
    }];
}

- (void)onCameraTypeSwitchCompleted:(NIMNetCallCamera)cameraType{
    self.camera = cameraType;
}

- (void)onCameraOrientationSwitchCompleted:(NIMVideoOrientation)orientation{
    if (orientation == NIMVideoOrientationLandscapeRight) {
        self.isPortrait = NO;
    } else {
        self.isPortrait = YES;
    }
}

#pragma mark - 旋转屏幕

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 懒加载

- (PreLiveView *)maskview{
    if (!_maskview) {
        _maskview = [[PreLiveView alloc] init];
        [self.view addSubview:_maskview];
        [_maskview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo(0);
        }];
        
    }
    return _maskview;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
