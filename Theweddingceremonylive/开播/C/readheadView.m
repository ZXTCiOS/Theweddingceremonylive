//
//  readheadView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "readheadView.h"

@interface readheadView()
@property (nonatomic,strong) UIImageView *headimg;
@property (nonatomic,strong) UILabel *headlab;
@end

@implementation readheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headimg];
        [self addSubview:self.headlab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headimg.frame = CGRectMake(kScreenW/2-60*WIDTH_SCALE, 50*HEIGHT_SCALE, 120*WIDTH_SCALE, 72*HEIGHT_SCALE);
    self.headlab.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 150*HEIGHT_SCALE, 200*WIDTH_SCALE, 40*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)headimg
{
    if(!_headimg)
    {
        _headimg = [[UIImageView alloc] init];
        _headimg.image = [UIImage imageNamed:@"zb_smrz_pic"];
    }
    return _headimg;
}

-(UILabel *)headlab
{
    if(!_headlab)
    {
        _headlab = [[UILabel alloc] init];
        _headlab.text = @"完成身份验证，可核对真实身份，保障合法权益";
        _headlab.textAlignment = NSTextAlignmentCenter;
        _headlab.numberOfLines = 2;
        _headlab.font = [UIFont systemFontOfSize:14];
        _headlab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _headlab;
}




@end
