//
//  UITabBarController+QFExtension.h
//  Limit
//
//  Created by luds on 15/10/26.
//  Copyright © 2015年 luds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (QFExtension)

/** 快速添加视图控制器 */
- (void)addViewController:(UIViewController *)vc
                    title:(NSString *)title
                    image:(NSString *)image
            selectedImage:(NSString *)selectedImage;

@end
