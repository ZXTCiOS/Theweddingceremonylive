//
//  HorizontalPushVCViewController.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"
#import <NIMSDK/NIMSDK.h>// 网易互动直播头文件
#import <NIMAVChat/NIMAVChat.h>
@interface HorizontalPushVCViewController : BaseViewController

@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *biaoti;
@property (nonatomic, assign) NIMNetCallCamera camera;
@property (nonatomic, strong) NSString *orderID;

- (instancetype)initWithChatroomID:(NSString *) roomid pushurl:(NSString *)pushUrl yue:(CGFloat) yue;


@end
