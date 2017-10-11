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
             @"gk": [WeddingLiveDataLivingModel class],
             @"sm": [WeddingLiveDataLivingModel class],
             @"jq": [WeddingLiveDataLivingModel class]
             };
}



@end

@implementation WeddingLiveDataLivingModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"room_data": [WeddingLiveDataLiveDataModel class]
             };
}



@end

@implementation WeddingLiveDataLiveDataModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"user_uid":@"uid"
             };
}

@end
@implementation tuilaliu



@end
@implementation tuilaliuret



@end

