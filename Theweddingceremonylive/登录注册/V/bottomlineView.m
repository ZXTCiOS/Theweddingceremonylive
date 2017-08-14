//
//  bottomlineView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bottomlineView.h"

@interface bottomlineView()
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UILabel *lab;
@end

@implementation bottomlineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.line0];
        [self addSubview:self.line1];
        [self addSubview:self.lab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.line0.frame = CGRectMake(0, self.frame.size.height/2, 100*WIDTH_SCALE, 1);
    
    self.line1.frame = CGRectMake(self.frame.size.width/2+20*WIDTH_SCALE, self.frame.size.height/2, 100*WIDTH_SCALE, 1);
    self.lab.frame = CGRectMake(self.frame.size.width/2-40*WIDTH_SCALE, 0, 80*WIDTH_SCALE, self.frame.size.height);
}

#pragma mark - getters

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"c7c7cd"];
    }
    return _line0;
}

-(UIView *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"c7c7cd"];
    }
    return _line1;
}

-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.text = @"其他方式";
        _lab.textColor = [UIColor colorWithHexString:@"c7c7cd"];
        _lab.font = [UIFont systemFontOfSize:12];
    }
    return _lab;
}





@end
