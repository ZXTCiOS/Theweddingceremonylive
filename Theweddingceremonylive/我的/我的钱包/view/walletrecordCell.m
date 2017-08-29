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
        
    }];
    [weakSelf.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [weakSelf.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [weakSelf.balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
        
    }
    return _nameLab;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        
    }
    return _timeLab;
}

-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        
    }
    return _priceLab;
}

-(UILabel *)balanceLab
{
    if(!_balanceLab)
    {
        _balanceLab = [[UILabel alloc] init];
        
    }
    return _balanceLab;
}


@end
