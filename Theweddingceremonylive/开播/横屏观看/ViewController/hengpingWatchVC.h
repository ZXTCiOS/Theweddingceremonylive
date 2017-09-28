//
//  hengpingWatchVC.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hengpingWatchVC : UIViewController
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *roomid;

@property (nonatomic, copy) NSString *zhubo_name;
@property (nonatomic, copy) NSString *zhubo_img;
@property (nonatomic, copy) NSString *zhubo_uid;

- (instancetype)initWithChatroomID:(NSString *)roomid Url:(NSString *) url meetingname:(NSString *) meetingname;


@end
