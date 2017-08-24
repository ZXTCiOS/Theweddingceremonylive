//
//  TuijianDataModel.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TuijianDataModel.h"

@implementation TuijianDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [TuiJDataModel class]
             };
}




@end

@implementation TuiJDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"lunbo": [TuiJjianLunboModel class],
             @"data": [TuiJianModel class]
             
             };
}



@end

@implementation TuiJjianLunboModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"ident": @"id"
             };
}

@end



