//
//  LLQImageView.h
//  LLQImageView
//
//  Created by LLQ on 16/6/15.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLQImageView : UIView

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,assign)NSInteger index;

@end




//子类化一个ImageView作为九宫格单元格的类
@interface LLQImageItem : UIImageView

//记录下标
@property(nonatomic,assign)NSInteger index;
//记录原始坐标
@property(nonatomic,assign)CGRect originFrame;

//添加点击事件的初始化方法
- (instancetype)initWithFrame:(CGRect)frame withTarget:(id)target sel:(SEL)action;


@end