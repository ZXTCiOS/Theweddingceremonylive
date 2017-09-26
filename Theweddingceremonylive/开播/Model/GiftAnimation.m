//
//  GiftAnimation.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "GiftAnimation.h"
#import <UIImage+GIF.h>
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+RotateImgV.h"
#define imageW 300
#define imageH 300
#define movedistance  200

@implementation GiftAnimation



+ (void)giftWithImage:(NSString *)imageName animationType:(giftAnimationType)type addedToView:(UIView *)view duration:(NSInteger)duration audioName:(NSString *)audio conpletion:(block)handler{
    NSString *name = [NSString stringWithFormat:@"%@.gif", imageName];
    UIImage *image = [YYImage imageNamed:name];
    UIImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:image];
    imgV.animationRepeatCount = 10;
    imgV.contentMode = UIViewContentModeCenter;
    [view addSubview:imgV];
    imgV.frame = CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2, imageW, imageH);
    imgV.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    /*
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (type == giftAnimationTypeCircle) {
                //imgV.center = CGPointMake(kScreenW/2, kScreenH/2);
                
                //imgV.transform = CGAffineTransformMakeRotation(5*M_PI);
                
                imgV.transform = CGAffineTransformRotate(imgV.transform, 2*M_PI-0.01);
            } else if (type == giftAnimationTypeTop) {
                imgV.frame = CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2 - movedistance, imageW, imageH);
            } else {
                
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                imgV.alpha = 0;
            } completion:^(BOOL finished) {
                [imgV removeFromSuperview];
                !handler ?: handler();
            }];
        }];
    }];*/
    
    
    
    
    
    
    switch (type) {
        case giftAnimationTypeTop:{
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    imgV.frame = CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2 - movedistance, imageW, imageH);
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        imgV.alpha = 0;
                    } completion:^(BOOL finished) {
                        [imgV removeFromSuperview];
                        !handler ?: handler();
                    }];
                }];
            }];
        }
            break;
        case giftAnimationTypeStatic:{
            
            [UIView animateWithDuration:0.5 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
                imgV.alpha = 0;
            } completion:^(BOOL finished) {
                [imgV removeFromSuperview];
                !handler ?: handler();
            }];
        }
            break;
        case giftAnimationTypeCircle:{
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                        
                    imgV.transform = CGAffineTransformRotate(imgV.transform, M_PI);
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        imgV.alpha = 0;
                    } completion:^(BOOL finished) {
                        [imgV removeFromSuperview];
                        !handler ?: handler();
                    }];
                }];
            }];
            
//            [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
//                
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    
//                    [imgV rotate360DegreeWithImageView];
//                    
//                } completion:^(BOOL finished) {
//                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                        imgV.alpha = 0;
//                    } completion:^(BOOL finished) {
//                        [imgV stopRotate];
//                        [imgV removeFromSuperview];
//                        !handler ?: handler();
//                    }];
//                }];
//            }];
            
        }
            break;
        default:
            break;
    }
    
    
    
    
    if (![audio isEqualToString:@"none"]) {
        //本地url
        NSString *filePath = [[NSBundle mainBundle] pathForResource:audio ofType:@"mp3"];
        //将该路径转成url格式
        NSURL *url = [NSURL fileURLWithPath:filePath];
        //(1) 注册系统声音(c函数调用)
        //soundID:标示音频
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        //(2)播放
        AudioServicesPlaySystemSound(soundID);
    }
}



@end
