//
//  NvwaHeaderModel.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NvwaHeaderModel : NSObject

@property (nonatomic, copy) NSString *nvwa_title;

@property (nonatomic, copy) NSString *nvwa_is_zb;

@property (nonatomic, copy) NSString *nvwa_img;

@property (nonatomic, copy) NSString *nvwa_zhibo_url;



@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *roomid;
@property (nonatomic, copy) NSString *zhubo_name;
@property (nonatomic, copy) NSString *zhubo_img;
@property (nonatomic, copy) NSString *zhubo_uid;
@property (nonatomic, assign) weddingType weddingtype;
@property (nonatomic, copy) NSString *direction;







@end
