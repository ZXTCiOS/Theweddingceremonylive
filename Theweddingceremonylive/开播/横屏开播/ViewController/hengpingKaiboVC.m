//
//  hengpingKaiboVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "hengpingKaiboVC.h"

@interface hengpingKaiboVC ()

@end

@implementation hengpingKaiboVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    
}



#pragma mark - 强制旋转屏幕为横屏

- (BOOL)shouldAutorotate
{
    return YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
