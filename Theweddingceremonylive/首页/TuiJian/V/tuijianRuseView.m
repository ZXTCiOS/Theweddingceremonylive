//
//  tuijianRuseView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "tuijianRuseView.h"

@implementation tuijianRuseView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 220 / 760.0)];
    if (self) {
        [self loopV];
    }
    return self;
}



- (HYBLoopScrollView *)loopV{
    if (!_loopV) {
        _loopV = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 220 / 760.0) imageUrls:@[] timeInterval:2 didSelect:^(NSInteger atIndex) {
            
            !_block ?: _block(atIndex);
            
            NSLog(@"%ld", atIndex);
        } didScroll:nil];
        _loopV.placeholder = [UIImage imageNamed:@""];
        [self addSubview:_loopV];
    }
    return _loopV;
}


@end
