//
//  WeddingLiveModel.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WeddingLiveModel.h"

@implementation WeddingLiveModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [WeddingLiveDataModel class]
             };
}


@end

@implementation WeddingLiveDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"room_public": [WeddingLiveDataLivingModel class],
             @"room_private": [WeddingLiveDataLivingModel class],
             @"room_future": [WeddingLiveDataLivingModel class]
             };
}

@end

@implementation WeddingLiveDataLivingModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [WeddingLiveDataLiveDataModel class]
             };
}

@end

@implementation WeddingLiveDataLiveDataModel



@end



