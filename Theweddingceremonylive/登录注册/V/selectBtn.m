//
//  selectBtn.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "selectBtn.h"

@implementation selectBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.setLab];
        [self addSubview:self.setImg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.setLab.frame = CGRectMake(0, 0, 40, 20);
    self.setImg.frame = CGRectMake(40, 0, 20, 20);
}

#pragma mark - getters

-(UILabel *)setLab
{
    if(!_setLab)
    {
        _setLab = [[UILabel alloc] init];
        
    }
    return _setLab;
}


-(UIImageView *)setImg
{
    if(!_setImg)
    {
        _setImg = [[UIImageView alloc] init];
        
    }
    return _setImg;
}



@end
