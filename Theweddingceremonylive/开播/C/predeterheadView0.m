//
//  predeterheadView0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "predeterheadView0.h"


@interface predeterheadView0()
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;

@property (nonatomic,strong) UIImageView *bgimg;
@end

@implementation predeterheadView0

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lab1];
        [self addSubview:self.lab2];
        
        [self addSubview:self.bgimg];
        
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
        
    }];
    
    [weakSelf.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab1.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab1);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.text = @"婚礼日期";
        _lab1.textColor = [UIColor colorWithHexString:@"333333"];
        _lab1.font = [UIFont systemFontOfSize:15];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.font = [UIFont systemFontOfSize:15];
        _lab2.textColor = [UIColor colorWithHexString:@"999999"];
        _lab2.text = @"(公历日期)";
    }
    return _lab2;
}

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"datebackground"];
    }
    return _bgimg;
}





@end
