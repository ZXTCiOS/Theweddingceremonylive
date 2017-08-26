//
//  keyboardView.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGtextView.h"

@interface keyboardView : UIView
@property (nonatomic,strong) UIButton *sendbtn;
@property (nonatomic,strong) WJGtextView *textview;

@property (nonatomic,strong) NSString *indexstr;
@end
