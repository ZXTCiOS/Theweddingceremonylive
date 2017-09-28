//
//  walletlistModel.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface walletlistModel : NSObject
//礼物
@property (nonatomic,strong) NSString *giftinfo_addtime;
@property (nonatomic,strong) NSString *giftinfo_giftid;
@property (nonatomic,strong) NSString *giftinfo_id;
@property (nonatomic,strong) NSString *giftinfo_userid;
@property (nonatomic,strong) NSString *giftinfo_yue;
@property (nonatomic,strong) NSString *giftinfo_price;

//提现
@property (nonatomic,strong) NSString *bankid;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *id_card;
@property (nonatomic,strong) NSString *is_give;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *userid;

//充值
//@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *goin_id;
@property (nonatomic,strong) NSString *goin_moeny;
@property (nonatomic,strong) NSString *goin_userid;

@property (nonatomic,strong) NSString *yue;
@end
