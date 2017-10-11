//
//  PortraitFullViewController.h
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortraitFullViewController : UIViewController

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *roomid;

@property (nonatomic, copy) NSString *zhubo_name;
@property (nonatomic, copy) NSString *zhubo_img;
@property (nonatomic, copy) NSString *zhubo_uid;

@property (nonatomic, assign) weddingType weddingtype;

- (instancetype)initWithChatroomID:(NSString *)roomid Url:(NSString *) url meetingname:(NSString *) meetingname;


@end
