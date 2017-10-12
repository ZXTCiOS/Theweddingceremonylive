//
//  WeddingLiveModel.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WeddingLiveDataModel, WeddingLiveDataLivingModel, WeddingLiveDataLiveDataModel, tuilaliu, tuilaliuret;
@interface WeddingLiveModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) WeddingLiveDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end

@interface WeddingLiveDataModel : NSObject

@property (nonatomic, strong) WeddingLiveDataLivingModel *gk;

@property (nonatomic, strong) WeddingLiveDataLivingModel *sm;

@property (nonatomic, strong) NSArray<WeddingLiveDataLivingModel *> *jq;

@end

@interface WeddingLiveDataLivingModel : NSObject

@property (nonatomic, copy) NSString *room_renshu;

@property (nonatomic, strong) NSArray<WeddingLiveDataLiveDataModel *> *room_data;

@property (nonatomic, strong) NSString *time;

@end



@interface WeddingLiveDataLiveDataModel : NSObject

@property (nonatomic, copy) NSString *pindao_direction;// 方向
@property (nonatomic, copy) NSString *room_img; //大图
@property (nonatomic, copy) NSString *pindao_renshu;//
@property (nonatomic, copy) NSString *room_name;//房间名
@property (nonatomic, assign) BOOL is_pwd;      //是否有密码
@property (nonatomic, strong) tuilaliu *tuilaliu; //
@property (nonatomic, copy) NSString *roomid;   // 聊天室 ID
@property (nonatomic, copy) NSString *order_password;//密码
@property (nonatomic, copy) NSString *pattren;  //直播间类型
@property (nonatomic, copy) NSString *uid;      //
@property (nonatomic, copy) NSString *username; //主播名称
@property (nonatomic, copy) NSString *picture;  //主播头像
@property (nonatomic, copy) NSString *room_yangshi;


@end

@interface tuilaliu : NSObject

@property (nonatomic, strong) tuilaliuret *ret;


@end

@interface tuilaliuret : NSObject

@property (nonatomic, copy) NSString *rtmpPullUrl;
@property (nonatomic, copy) NSString *hlsPullUrl;
@property (nonatomic, copy) NSString *httpPullUrl;

@end





