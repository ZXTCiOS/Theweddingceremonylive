//
//  walletrecordCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/29.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "walletrecordCell.h"

@interface walletrecordCell()
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *balanceLab;
@property (nonatomic,strong) UIImageView *typeImg;
@end

@implementation walletrecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.balanceLab];
        [self.contentView addSubview:self.typeImg];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(14*HEIGHT_SCALE);
        make.height.mas_offset(36*WIDTH_SCALE);
        make.width.mas_offset(36*WIDTH_SCALE);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(14*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(5*HEIGHT_SCALE);
    }];
    [weakSelf.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nameLab);
    }];
    [weakSelf.balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.priceLab);
        make.top.equalTo(weakSelf.timeLab);
    }];
    [weakSelf.typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab.mas_right).with.offset(6*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"my_walet_cz"];
    }
    return _leftImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.font = [UIFont systemFontOfSize:17];
        _nameLab.text = @"充值";
    }
    return _nameLab;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLab.font = [UIFont systemFontOfSize:14];
        
        NSString *str = @"1502850707";
        NSInteger inter = [str intValue];
        _timeLab.text = [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd"];

    }
    return _timeLab;
}

-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"+30.00";
        _priceLab.textColor = [UIColor colorWithHexString:@"333333"];
        _priceLab.font = [UIFont systemFontOfSize:17];
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}

-(UILabel *)balanceLab
{
    if(!_balanceLab)
    {
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = @"余额300";
        _balanceLab.font = [UIFont systemFontOfSize:14];
        _balanceLab.textColor = [UIColor colorWithHexString:@"999999"];
        _balanceLab.textAlignment = NSTextAlignmentRight;
    }
    return _balanceLab;
}

-(UIImageView *)typeImg
{
    if(!_typeImg)
    {
        _typeImg = [[UIImageView alloc] init];
        _typeImg.image = [UIImage imageNamed:@"my_walet_cg"];
    }
    return _typeImg;
}


#pragma mark - 将某个时间戳转化成 时间

-(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //format = @"YYYY-MM-dd hh:mm:ss";
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

@end
