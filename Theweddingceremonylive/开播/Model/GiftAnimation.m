//
//  GiftAnimation.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "GiftAnimation.h"
#import <UIImage+GIF.h>

#define imageW 100
#define imageH 100
#define movedistance  100

@implementation GiftAnimation

+ (void)giftWithImage:(NSString *)image animationType:(giftAnimationType)type addedToView:(UIView *)view conpletion:(block)handler{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW/2, kScreenH/2, 1, 1)];
    [view addSubview:imgV];
    imgV.image = [UIImage imageNamed:image];
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imgV.frame = CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2, imageW, imageH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (type == giftAnimationTypeCircle) {
                imgV.transform = CGAffineTransformMakeRotation(6 *M_PI);
            } else {
                imgV.frame = CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2 - movedistance, imageW, imageH);
            }
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

+ (void)giftWithGif:(NSString *)gif addedToView:(UIView *)view completion:(block)handler{
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - imageW)/2, (kScreenH - imageH)/2, imageW, imageH)];
    //imageV.animationImages
    NSString *path = [[NSBundle mainBundle] pathForResource:gif ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    imageV.image = image;
    imageV.animationDuration = 2;
    [view addSubview:imageV];
    [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageV.alpha = 0;
    } completion:^(BOOL finished) {
        [imageV removeFromSuperview];
        !handler ?: handler();
    }];
}

@end
