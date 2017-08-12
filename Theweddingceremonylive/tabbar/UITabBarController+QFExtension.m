//
//  UITabBarController+QFExtension.m
//  Limit
//
//  Created by luds on 15/10/26.
//  Copyright © 2015年 luds. All rights reserved.
//

#import "UITabBarController+QFExtension.h"

/** 版本判断 */
#define ios7_or_later [UIDevice currentDevice].systemVersion.floatValue >= 7.0

#define ios8_or_later [UIDevice currentDevice].systemVersion.floatValue >= 8.0

@implementation UITabBarController (QFExtension)

- (void)addViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    // 设置标题
    vc.title = title;
    // 做导航视图控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.tabBarItem.tag = 11;
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
    }
    
    /** iOS 7之后的原图处理 */
    UIImage *imageNormal = [UIImage imageNamed:image];
    if (ios7_or_later) {
        imageNormal = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    UIImage *imageSelected = [UIImage imageNamed:selectedImage];
    if (ios7_or_later) {
        imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    // 设置tabBar相关
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:imageNormal selectedImage:imageSelected];
    
    // 添加管理的子视图控制器
    [self addChildViewController:nav];
}

@end
