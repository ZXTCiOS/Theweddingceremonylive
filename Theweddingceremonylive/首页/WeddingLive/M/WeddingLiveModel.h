//
//  WeddingLiveModel.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WeddingLiveDataModel, WeddingLiveDataLivingModel, WeddingLiveDataLiveDataModel;
@interface WeddingLiveModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) WeddingLiveDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end

@interface WeddingLiveDataModel : NSObject

@property (nonatomic, strong) WeddingLiveDataLivingModel *room_public;

@property (nonatomic, strong) WeddingLiveDataLivingModel *room_private;

@property (nonatomic, strong) NSArray<WeddingLiveDataLivingModel *> *room_future;

@end

@interface WeddingLiveDataLivingModel : NSObject

@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSArray<WeddingLiveDataLiveDataModel *> *data;

@property (nonatomic, strong) NSString *time;

@end



@interface WeddingLiveDataLiveDataModel : NSObject

@property (nonatomic, copy) NSString *pindao_diretion;// 方向
@property (nonatomic, copy) NSString *room_img; //大图
@property (nonatomic, copy) NSString *pindao_renshu;//
@property (nonatomic, copy) NSString *room_name;//房间名
@property (nonatomic, assign) BOOL is_pwd;      //是否有密码
@property (nonatomic, copy) NSString *tuilaliu; //
@property (nonatomic, copy) NSString *roomid;   // 聊天室 ID
@property (nonatomic, copy) NSString *order_password;//密码
@property (nonatomic, copy) NSString *pattren;  //直播间类型
@property (nonatomic, copy) NSString *uid;      //
@property (nonatomic, copy) NSString *username; //主播名称
@property (nonatomic, copy) NSString *picture;  //主播头像



@end
