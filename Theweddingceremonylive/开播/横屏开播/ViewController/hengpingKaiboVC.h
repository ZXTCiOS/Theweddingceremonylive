//
//  hengpingKaiboVC.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NIMSDK/NIMSDK.h>// 网易互动直播头文件
#import <NIMAVChat/NIMAVChat.h>

@interface hengpingKaiboVC : UIViewController

@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *biaoti;
@property (nonatomic, assign) NIMNetCallCamera camera;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, assign) weddingType weddingtype;

- (instancetype)initWithChatroomID:(NSString *) roomid pushurl:(NSString *)pushUrl yue:(CGFloat) yue;

@end
