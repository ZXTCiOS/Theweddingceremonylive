//
//  livetypeCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "livetypeCell.h"

@implementation livetypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.numberlab];
        [self.contentView addSubview:self.pricelab];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
    }];
    
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(85*HEIGHT_SCALE);
    }];
    
    [weakSelf.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-15);
        make.height.mas_offset(16);
    }];
    
    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf.numberlab);
        make.width.mas_offset(80);
        make.height.mas_offset(16);
    }];
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.layer.masksToBounds = YES;
        _bgimg.layer.cornerRadius = 4;
    }
    return _bgimg;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textAlignment = NSTextAlignmentCenter;
        _typelab.textColor = [UIColor colorWithHexString:@"ffffff"];
        _typelab.font = [UIFont systemFontOfSize:21];
    }
    return _typelab;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textColor = [UIColor colorWithHexString:@"ffffff"];
        _numberlab.font = [UIFont systemFontOfSize:15];
    }
    return _numberlab;
}

-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.textColor = [UIColor colorWithHexString:@"ffffff"];
        _pricelab.font = [UIFont systemFontOfSize:15];
        _pricelab.textAlignment = NSTextAlignmentRight;
    }
    return _pricelab;
}


@end
