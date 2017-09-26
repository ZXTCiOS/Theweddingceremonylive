//
//  GiftAnimation.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiftModel.h"



typedef void (^block)();

@interface GiftAnimation : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gift_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) UIImage *gifImage;


+ (void)giftWithImage:(NSString *)imageName animationType:(giftAnimationType)type addedToView:(UIView *)view duration:(NSInteger)duration audioName:(NSString *)audio conpletion:(block)handler;

@end
