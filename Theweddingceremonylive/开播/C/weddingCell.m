//
//  weddingCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingCell.h"
#import "weddinglistModel.h"

@interface weddingCell()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UIButton *setBtn;
@property (nonatomic,strong) weddinglistModel *wmodel;
@end

@implementation weddingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.pricelab];
        [self.contentView addSubview:self.setBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
        make.width.mas_offset(103*WIDTH_SCALE);
    }];
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(123*WIDTH_SCALE);
        make.top.equalTo(weakSelf.leftimg);
        make.bottom.equalTo(weakSelf.leftimg);
        make.right.equalTo(weakSelf).with.offset(-15*WIDTH_SCALE);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgview.mas_left).with.offset(34*WIDTH_SCALE);
        make.top.equalTo(weakSelf.bgview).with.offset(16*HEIGHT_SCALE);

    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab);
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(5*HEIGHT_SCALE);
    }];
    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(5*HEIGHT_SCALE);
    }];
    [weakSelf.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgview.mas_right);
        make.top.equalTo(weakSelf.bgview.mas_top);
        make.width.mas_offset(25);
        make.height.mas_offset(25);
    }];
    
}

#pragma mark - getters


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        [_leftimg sd_setImageWithURL:[NSURL URLWithString:@"http://img2.3lian.com/2014/f4/184/d/117.jpg"]];
    }
    return _leftimg;
}

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgview;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.font = [UIFont systemFontOfSize:17];
        _typelab.text = @"高清版";
    }
    return _typelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"999999"];
        _contentlab.font = [UIFont systemFontOfSize:14];
        _contentlab.text = @"未剪辑，网盘下载";
    }
    return _contentlab;
}

-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _pricelab.font = [UIFont systemFontOfSize:16];
        _pricelab.text = @"¥50";
    }
    return _pricelab;
}

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];

        [_setBtn addTarget:self action:@selector(setBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

-(void)setdata:(weddinglistModel *)model
{
    self.wmodel = model;
    if (model.ischoose) {
        [_setBtn setImage:[UIImage imageNamed:@"zb_hllx_s"] forState:normal];
    }
    else
    {
        [_setBtn setImage:[UIImage imageNamed:@"zb_hllx_ns"] forState:normal];
    }
    [self.leftimg sd_setImageWithURL:[NSURL URLWithString:model.goods_info_img] placeholderImage:[UIImage imageNamed:@"tanchaung"]];
    self.typelab.text = model.name;
    self.pricelab.text = [NSString stringWithFormat:@"%@%@",@"¥:",model.money];
    self.contentlab.text = model.goods_jianjie;
}

-(void)setBtnclick
{
    [self.delegate choosebtnClick:self];
}

@end
