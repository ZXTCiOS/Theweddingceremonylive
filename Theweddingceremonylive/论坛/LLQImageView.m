//
//  LLQImageView.m
//  LLQImageView
//
//  Created by LLQ on 16/6/15.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "LLQImageView.h"
#import "UIImageView+WebCache.h"
#import "UIView+ViewController.h"
#import "LLQImageViewController.h"

#define kItemSpace 5

@implementation LLQImageView


//复写图片数组的set方法，赋值时创建九宫格
- (void)setData:(NSArray *)data{
    
    _data = data;
    
    //每次因为每次赋值都要添加图片视图，所以每次添加前先移除所有视图
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[LLQImageItem class]]) {
            
            [view removeFromSuperview];
            
        }
        
    }
    
    //创建图片视图
    for (int i = 0; i < _data.count; i ++) {
        
        LLQImageItem *item = [[LLQImageItem alloc] initWithFrame:[self frameAtIndex:i] withTarget:self sel:@selector(tapAction:)];
        item.index = i;
        item.originFrame = item.frame;
        item.tag = i+1;
        
        [item setImageWithURL:[NSURL URLWithString:_data[i]]];
        [self addSubview:item];
        
    }
    
}

//点击事件
- (void)tapAction:(UIGestureRecognizer *)tap{
    
    //获取点击的视图
    LLQImageItem *view = (LLQImageItem *)tap.view;
    LLQImageViewController *vc = [[LLQImageViewController alloc] init];
    vc.item = view;
    vc.imageView = self;
    vc.data = _data;
    
    //弹出模态视图
    [view.viewController presentViewController:vc animated:NO completion:^{
    }];
    
}

//根据下标计算位置
- (CGRect)frameAtIndex:(NSInteger)index{
    
    //宽度
    CGFloat itemWith = (self.frame.size.width - 4*kItemSpace)/3;
    //x
    CGFloat x = (index%3) * itemWith + ((index%3)+1) * kItemSpace;
    //y
    CGFloat y = (index/3) * itemWith + ((index/3)+1) * kItemSpace;
    
    return CGRectMake(x, y, itemWith, itemWith);
    
}



@end



@implementation LLQImageItem

- (instancetype)initWithFrame:(CGRect)frame withTarget:(id)target sel:(SEL)action{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //图片填充方式
        self.contentMode = UIViewContentModeScaleAspectFit;
        //允许用户点击事件
        self.userInteractionEnabled = YES;
        
        //添加单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        //单击次数
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
    
}




@end