//
//  zhifuBtn.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "zhifuBtn.h"

@implementation zhifuBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textlab];
        [self addSubview:self.xuanzeimg];
        [self addSubview:self.rightimg];
    }
    return self;
}

#pragma mark - getters

-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.textColor = [UIColor colorWithHexString:@"333333"];
        _textlab.font = [UIFont systemFontOfSize:15];
    }
    return _textlab;
}

-(UIImageView *)xuanzeimg
{
    if(!_xuanzeimg)
    {
        _xuanzeimg = [[UIImageView alloc] init];
        _xuanzeimg.image = [UIImage imageNamed:@"my_walet_zfb"];
    }
    return _xuanzeimg;
}

-(UIImageView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIImageView alloc] init];
        _rightimg.image = [UIImage imageNamed:@"my_walet_select"];
    }
    return _rightimg;
}






@end
