//
//  SendRedBagView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendRedBagView : UIView

@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) IBOutlet UIButton *sendBtn;
@property (nonatomic, strong) IBOutlet UIButton *chongzhiBtn;
@property (nonatomic, strong) IBOutlet UIButton *normal;
@property (nonatomic, strong) IBOutlet UIButton *random;
@property (nonatomic, strong) IBOutlet UITextField * money;
@property (nonatomic, strong) IBOutlet UITextField *number;
@property (nonatomic, strong) IBOutlet UITextField *kouling;

@property (nonatomic, assign) BOOL isnormal; // 是否是普通红包

@end
