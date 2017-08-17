//
//  infoCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoCell1.h"

@interface infoCell1()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UIButton *liveBtn;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *idLab;
@end

@implementation infoCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.liveBtn];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.idLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(8*HEIGHT_SCALE);
        make.height.mas_offset(14*HEIGHT_SCALE);
    }];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(40*HEIGHT_SCALE);
        make.width.mas_offset(40*WIDTH_SCALE);
        make.height.mas_offset(40*WIDTH_SCALE);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(68*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(47*HEIGHT_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
    }];
    [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.height.mas_offset(11*HEIGHT_SCALE);
    }];
    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-50*HEIGHT_SCALE);
        make.width.mas_offset(68*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"直播";
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.font = [UIFont systemFontOfSize:15];
    }
    return _typelab;
}

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"my_gift_list_zl"];
    }
    return _leftImg;
}


-(UIButton *)liveBtn
{
    if(!_liveBtn)
    {
        _liveBtn = [[UIButton alloc] init];
        [_liveBtn setImage:[UIImage imageNamed:@"my_gift_list_zl_jr"] forState:normal];
    }
    return _liveBtn;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.text = @"直播间名字";
    }
    return _nameLab;
}

-(UILabel *)idLab
{
    if(!_idLab)
    {
        _idLab = [[UILabel alloc] init];
        _idLab.text = @"id-666";
        _idLab.textColor = [UIColor colorWithHexString:@"999999"];
        _idLab.font = [UIFont systemFontOfSize:11];
    }
    return _idLab;
}







@end
