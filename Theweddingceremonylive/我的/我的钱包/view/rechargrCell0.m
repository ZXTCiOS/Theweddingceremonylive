//
//  rechargrCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rechargrCell0.h"

@interface rechargrCell0()
@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *moneyLab;

@end

@implementation rechargrCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.moneyLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(22*HEIGHT_SCALE);
        make.width.mas_offset(55*WIDTH_SCALE);
        make.height.mas_offset(55*WIDTH_SCALE);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImg.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.iconImg).with.offset(6*HEIGHT_SCALE);
    }];
    [weakSelf.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(10*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)iconImg
{
    if(!_iconImg)
    {
        _iconImg = [[UIImageView alloc] init];
        [_iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://pic28.photophoto.cn/20130821/0008020280905409_b.jpg"]];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 55/2*WIDTH_SCALE;

    }
    return _iconImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.text = @"账户：姓名";
    }
    return _nameLab;
}

-(UILabel *)moneyLab
{
    if(!_moneyLab)
    {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.textColor = [UIColor colorWithHexString:@"333333"];
        _moneyLab.font = [UIFont systemFontOfSize:15];
        _moneyLab.text = @"余额：¥3";
    }
    return _moneyLab;
}

@end
