//
//  mineheadView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineheadView.h"

@interface mineheadView()
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;

@end

@implementation mineheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.userImg];
        [self addSubview:self.nameLab];

        [self addSubview:self.line0];
        [self addSubview:self.line1];
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
     __weak typeof (self) weakSelf = self;
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(kScreenW/2-33*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(29*HEIGHT_SCALE);
        make.width.mas_offset(66*WIDTH_SCALE);
        make.height.mas_offset(66*WIDTH_SCALE);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.userImg.mas_bottom).with.offset(20*HEIGHT_SCALE);
        
    }];
    

    [self.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(35*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(76*WIDTH_SCALE);
        make.height.mas_offset(70*HEIGHT_SCALE);
    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn0.mas_right).with.offset(44*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(76*WIDTH_SCALE);
        make.height.mas_offset(70*HEIGHT_SCALE);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(44*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(76*WIDTH_SCALE);
        make.height.mas_offset(70*HEIGHT_SCALE);
    }];
    
    [self.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn0.mas_right).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0.mas_top).with.offset(16*HEIGHT_SCALE);
        make.width.mas_offset(1);
        make.height.mas_offset(25*HEIGHT_SCALE);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0.mas_top).with.offset(16*HEIGHT_SCALE);
        make.width.mas_offset(1);
        make.height.mas_offset(25*HEIGHT_SCALE);
    }];
    
}

#pragma mark - getters

-(UIImageView *)userImg
{
    if(!_userImg)
    {
        _userImg = [[UIImageView alloc] init];
        _userImg.image = [UIImage imageNamed:@"my_mrt"];
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.cornerRadius = 33*WIDTH_SCALE;
    }
    return _userImg;
}

-(UILabel *)nameLab1
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.textAlignment = NSTextAlignmentCenter;

    }
    return _nameLab;
}


-(systenBtn *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[systenBtn alloc] init];
        _btn0.typeLab.text = @"系统消息";
        _btn0.typeImg.image = [UIImage imageNamed:@"my_message"];
    }
    return _btn0;
}

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _line0;
}

-(UIView *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _line1;
}

-(systenBtn *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[systenBtn alloc] init];
        _btn1.typeLab.text = @"修改资料";
        _btn1.typeImg.image = [UIImage imageNamed:@"my_zl"];
        [_btn1.redImg setHidden:YES];
    }
    return _btn1;
}

-(systenBtn *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[systenBtn alloc] init];
        _btn2.typeImg.image = [UIImage imageNamed:@"my_safe"];
        _btn2.typeLab.text = @"安全中心";
        [_btn2.redImg setHidden:YES];
    }
    return _btn2;
}




@end
