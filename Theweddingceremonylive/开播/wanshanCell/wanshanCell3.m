//
//  wanshanCell3.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wanshanCell3.h"

@interface wanshanCell3()
@property (nonatomic,strong) UILabel *typelab;
@end

@implementation wanshanCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.btn0];
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
    }];
    [weakSelf.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
        make.bottom.equalTo(weakSelf.btn0);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [weakSelf.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn0.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
        make.bottom.equalTo(weakSelf.btn0);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [weakSelf.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
        make.bottom.equalTo(weakSelf.btn0);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"直播边框";
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _typelab;
}

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        [_btn0 setTitle:@"中式" forState:normal];
        _btn0.layer.masksToBounds = YES;
        _btn0.layer.cornerRadius = 4*HEIGHT_SCALE;
        _btn0.layer.borderWidth = 1;
        _btn0.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        _btn0.titleLabel.font = [UIFont systemFontOfSize:17];
        _btn0.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [_btn0 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
        
        [_btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setTitle:@"西式" forState:normal];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.cornerRadius = 4*HEIGHT_SCALE;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        _btn1.titleLabel.font = [UIFont systemFontOfSize:17];
        _btn1.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [_btn1 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
        
        [_btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setTitle:@"无" forState:normal];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.cornerRadius = 4*HEIGHT_SCALE;
        _btn2.layer.borderWidth = 1;
        _btn2.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _btn2.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
        _btn2.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btn2 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
        
        [_btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}


-(void)btn0click
{
    _btn0.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
    [_btn0 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
    _btn0.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    
    _btn1.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn1.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn1 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
    
    _btn2.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn2.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn2 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
}

-(void)btn1click
{
    _btn1.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
    [_btn1 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
    _btn1.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    
    _btn0.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn0.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn0 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
    
    _btn2.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn2.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn2 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
}

-(void)btn2click
{
    _btn2.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
    [_btn2 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
    _btn2.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    
    _btn0.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn0.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn0 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
    
    _btn1.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _btn1.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_btn1 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
}

-(void)setdatabtn:(NSString *)btnstr
{
    if ([btnstr isEqualToString:@"1"]) {
        [self btn0click];
    }
    if ([btnstr isEqualToString:@"2"]) {
        [self btn1click];
    }
    if ([btnstr isEqualToString:@"3"]) {
        [self btn2click];
    }
}

@end
