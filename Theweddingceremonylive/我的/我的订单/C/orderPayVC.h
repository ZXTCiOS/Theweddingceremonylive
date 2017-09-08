//
//  orderPayVC.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface orderPayVC : BaseViewController
@property (nonatomic,strong) NSString *order_pattern;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *room_count;
@property (nonatomic,strong) NSString *tuijian;

@property (nonatomic,strong) NSString *order_goods;
@property (nonatomic,strong) NSString *order_goods_tuijian;

@property (nonatomic,strong) NSString *order_price;

@property (nonatomic,strong) NSString *price0;
@property (nonatomic,strong) NSString *price1;
@property (nonatomic,strong) NSString *price2;

@property (nonatomic,strong) NSString *name0;
@property (nonatomic,strong) NSString *name1;
@property (nonatomic,strong) NSString *name2;

@property (nonatomic,strong) NSString *ordersn;
@end
