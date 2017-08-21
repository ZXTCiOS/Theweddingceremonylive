//
//  MyshopCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MyshopCell.h"
#import "myshopModel.h"
@interface MyshopCell()
@property (nonatomic,strong) UIImageView *shopImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *setBtn;
@property (nonatomic,strong) myshopModel *smodel;
@end

@implementation MyshopCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.shopImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.setBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(90*HEIGHT_SCALE);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf.shopImg.mas_bottom).with.offset(11*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
        make.width.mas_offset(weakSelf.frame.size.width-30*WIDTH_SCALE);
    }];
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.nameLab);
        make.height.mas_offset(18*WIDTH_SCALE);
        make.width.mas_offset(18*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)shopImg
{
    if(!_shopImg)
    {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.backgroundColor = [UIColor lightGrayColor];
    }
    return _shopImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.text = @"商店商店";
    }
    return _nameLab;
}

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];
        [_setBtn setImage:[UIImage imageNamed:@"my_business_d"] forState:normal];
        [_setBtn addTarget:self action:@selector(setbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

-(void)setbtnclick
{
    [self.delegate submitbtnClick:self];
}

-(void)setdata:(myshopModel *)model
{
    self.smodel = model;
    self.nameLab.text = model.name;
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:nil];
}




@end
