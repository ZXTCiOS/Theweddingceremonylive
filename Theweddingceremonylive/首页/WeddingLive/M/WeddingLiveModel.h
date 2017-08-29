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

@property (nonatomic, strong) NSString *date;

@end



@interface WeddingLiveDataLiveDataModel : NSObject

@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL hasLock;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *room_id;


@end
