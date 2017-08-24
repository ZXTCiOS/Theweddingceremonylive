//
//  realfootView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realfootView.h"

@interface realfootView()

@end

@implementation realfootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftimg];
        [self addSubview:self.rightimg];
        [self addSubview:self.submitBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimg.frame = CGRectMake(10*WIDTH_SCALE, 5*HEIGHT_SCALE, kScreenW/2-10*WIDTH_SCALE, 108*HEIGHT_SCALE);
    self.rightimg.frame = CGRectMake(kScreenW/2+5, 5*HEIGHT_SCALE, kScreenW/2-10*WIDTH_SCALE, 108*HEIGHT_SCALE);
    self.submitBtn.frame = CGRectMake(kScreenW/2-120*WIDTH_SCALE, 140*HEIGHT_SCALE, 240*WIDTH_SCALE, 45*HEIGHT_SCALE);
}

#pragma mark - getters


-(cardimgView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[cardimgView alloc] init];
        _leftimg.cardlab.text = @"请上传身份证正面";
        _leftimg.userInteractionEnabled = YES;
    }
    return _leftimg;
}

-(cardimgView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[cardimgView alloc] init];
        _rightimg.cardlab.text = @"请上传身份证反面";
        _rightimg.userInteractionEnabled = YES;
    }
    return _rightimg;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"提交" forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 45/2*HEIGHT_SCALE;
    }
    return _submitBtn;
}





@end
