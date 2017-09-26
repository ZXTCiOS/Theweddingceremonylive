//
//  GiftModel.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, giftAnimationType) {
    giftAnimationTypeTop,
    giftAnimationTypeCircle,
    giftAnimationTypeStatic
};

@interface GiftModel : NSObject

@property (nonatomic, strong) NSString *towuid;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gift_name;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *pigurl;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) BOOL isMute;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *audioName;
@property (nonatomic, assign) giftAnimationType animation;



+ (instancetype)giftWithGiftID:(NSString *) gift_id name:(NSString *)name picture:(NSString *) pic price:(NSInteger) price animationType:(giftAnimationType) animation duration:(NSInteger) duration audioName:(NSString *) audio;





@end
