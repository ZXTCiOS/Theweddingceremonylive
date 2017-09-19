//
//  GiftAnimation.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, giftAnimationType) {
    giftAnimationTypeTop,
    giftAnimationTypeCircle,
};

typedef void (^block)();

@interface GiftAnimation : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gift_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) UIImage *gifImage;


+ (void)giftWithImage:(NSString *) image animationType:(giftAnimationType) type addedToView:(UIView *)view conpletion:(block) handler;

+ (void)giftWithGif:(NSString *)gif addedToView:(UIView *)view completion:(block) handler;


@end
