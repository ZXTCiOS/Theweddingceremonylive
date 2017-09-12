//
//  systenBtn.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "systenBtn.h"

@implementation systenBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.typeImg];
        [self addSubview:self.typeLab];
        [self addSubview:self.redImg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.typeImg.frame = CGRectMake(30*WIDTH_SCALE, 10*HEIGHT_SCALE, 16*WIDTH_SCALE, 16*WIDTH_SCALE);
    self.typeLab.frame = CGRectMake(0, 30*WIDTH_SCALE, 76*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.redImg.frame = CGRectMake(40*WIDTH_SCALE, 10*HEIGHT_SCALE, 6*WIDTH_SCALE, 6*WIDTH_SCALE);
}

#pragma mark - getters

-(UIImageView *)typeImg
{
    if(!_typeImg)
    {
        _typeImg = [[UIImageView alloc] init];
        
    }
    return _typeImg;
}

-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textAlignment = NSTextAlignmentCenter;
        _typeLab.textColor = [UIColor colorWithHexString:@"666666"];
        _typeLab.font = [UIFont systemFontOfSize:13];
    }
    return _typeLab;
}
 
-(UIImageView *)redImg
{
    if(!_redImg)
    {
        _redImg = [[UIImageView alloc] init];
        _redImg.image = [UIImage imageNamed:@"my_poin"];
    }
    return _redImg;
}




@end
