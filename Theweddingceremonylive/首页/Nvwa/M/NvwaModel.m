//
//  NvwaModel.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "NvwaModel.h"

@implementation NvwaModel


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"yugao": [NvwaYugaoModel class],
             @"jmb": [LieBiaoModel class]
             };
}






@end
