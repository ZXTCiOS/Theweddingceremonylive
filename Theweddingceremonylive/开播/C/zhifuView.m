//
//  zhifuView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "zhifuView.h"

@interface zhifuView()
@property (nonatomic,strong) UILabel *leftlab;

@end

@implementation zhifuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftlab];
        [self addSubview:self.rightbtn];
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlab.frame = CGRectMake(14*WIDTH_SCALE, 10, 100*WIDTH_SCALE, 20);
    self.rightbtn.frame = CGRectMake(self.frame.size.width-50, 10, 30, 30);
    
    self.btn0.frame = CGRectMake(55, 50*HEIGHT_SCALE, 60, 60);
    self.btn1.frame = CGRectMake(self.frame.size.width/2+55, 50*HEIGHT_SCALE, 60, 60);
    
}

#pragma mark - getters


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"支付方式";
        _leftlab.textColor = [UIColor colorWithHexString:@"333333"];
        _leftlab.font = [UIFont systemFontOfSize:14];
    }
    return _leftlab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
       // [_rightbtn setImage:[UIImage imageNamed:@""] forState:normal];
        [_rightbtn setTitle:@"X" forState:normal];
        [_rightbtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:normal];
    }
    return _rightbtn;
}

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        [_btn0 setImage:[UIImage imageNamed:@"zf_wx"] forState:normal];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setImage:[UIImage imageNamed:@"zf_zfb"] forState:normal];
    }
    return _btn1;
}





@end

