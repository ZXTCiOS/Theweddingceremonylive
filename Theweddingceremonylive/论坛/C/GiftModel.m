//
//  GiftModel.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel




+ (instancetype)giftWithGiftID:(NSString *)gift_id name:(NSString *)name picture:(NSString *)pic price:(NSInteger)price isGIF:(BOOL)isgif{
    GiftModel *model = [[GiftModel alloc] init];
    
    model.towuid = gift_id;
    model.name = name;
    model.picture = pic;
    model.price = price;
    model.isgif = isgif;
    return model;
}



@end
