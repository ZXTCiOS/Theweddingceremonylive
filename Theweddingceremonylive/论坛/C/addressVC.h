//
//  addressVC.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"
//创建block
typedef void(^returnValueBlock)(NSString *content);

@interface addressVC : BaseViewController
@property(nonatomic,copy) returnValueBlock  returnvalueBlock;
@end
