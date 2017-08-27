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
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@end

@implementation predeterheadView0

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        [self addSubview:self.lab1];
        [self addSubview:self.lab2];
        [self addSubview:self.bgimg];
        [self addSubview:self.numlab0];
        [self addSubview:self.numlab1];
        [self addSubview:self.numlab2];
        [self addSubview:self.lab3];
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        [self addSubview:self.lab4];
        [self addSubview:self.selectbtn];
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
    
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab1);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(123*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.lab1.mas_bottom).with.offset(10*HEIGHT_SCALE);
    }];
    
    [weakSelf.numlab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(60*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(85*HEIGHT_SCALE);
        make.width.mas_offset(42*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [weakSelf.numlab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(kScreenW/2-21*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(85*HEIGHT_SCALE);
        make.width.mas_offset(42*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [weakSelf.numlab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-60*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(85*HEIGHT_SCALE);
        make.width.mas_offset(42*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [weakSelf.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.bgimg.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    
    CGFloat width = (kScreenW-50*WIDTH_SCALE)/4;
    
    [weakSelf.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab3.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(65*HEIGHT_SCALE);
        make.width.mas_offset(width);
    }];
    
    [weakSelf.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn0.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.height.mas_offset(65*HEIGHT_SCALE);
        make.width.mas_offset(width);
    }];
    
    [weakSelf.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.height.mas_offset(65*HEIGHT_SCALE);
        make.width.mas_offset(width);
    }];
    
    [weakSelf.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn2.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.height.mas_offset(65*HEIGHT_SCALE);
        make.width.mas_offset(width);
    }];
    
    [weakSelf.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    
    [weakSelf.selectbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lab4);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(16*WIDTH_SCALE);
//        make.width.mas_offset(16*WIDTH_SCALE);
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

-(UILabel *)numlab0
{
    if(!_numlab0)
    {
        _numlab0 = [[UILabel alloc] init];
        _numlab0.textAlignment = NSTextAlignmentCenter;
        _numlab0.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _numlab0.font = [UIFont systemFontOfSize:32];

    }
    return _numlab0;
}

-(UILabel *)numlab1
{
    if(!_numlab1)
    {
        _numlab1 = [[UILabel alloc] init];
        _numlab1.textAlignment = NSTextAlignmentCenter;
        _numlab1.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _numlab1.font = [UIFont systemFontOfSize:32];

    }
    return _numlab1;
}

-(UILabel *)numlab2
{
    if(!_numlab2)
    {
        _numlab2 = [[UILabel alloc] init];
        _numlab2.textAlignment = NSTextAlignmentCenter;
        _numlab2.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _numlab2.font = [UIFont systemFontOfSize:32];

    }
    return _numlab2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.font = [UIFont systemFontOfSize:15];
        _lab3.textColor = [UIColor colorWithHexString:@"333333"];
        _lab3.text = @"房间人数";
    }
    return _lab3;
}


-(selectnumBtn *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[selectnumBtn alloc] init];
        _btn0.backgroundColor = [UIColor whiteColor];
        _btn0.layer.masksToBounds = YES;
        _btn0.layer.cornerRadius = 5;
        _btn0.numlab.text = @"300人";
        _btn0.numlab.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _btn0.selimg.image = [UIImage imageNamed:@"zb_oroom_po_s"];
    }
    return _btn0;
}

-(selectnumBtn *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[selectnumBtn alloc] init];
        _btn1.backgroundColor = [UIColor whiteColor];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.cornerRadius = 5;
        _btn1.numlab.text = @"500人";
        _btn1.numlab.textColor = [UIColor colorWithHexString:@"333333"];
        _btn1.selimg.image = [UIImage imageNamed:@"zb_oroom_pt"];
    }
    return _btn1;
}


-(selectnumBtn *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[selectnumBtn alloc] init];
        _btn2.backgroundColor = [UIColor whiteColor];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.cornerRadius = 5;
        _btn2.numlab.text = @"1000人";
        _btn2.numlab.textColor = [UIColor colorWithHexString:@"333333"];
        _btn2.selimg.image = [UIImage imageNamed:@"zb_oroom_pth"];
    }
    return _btn2;
}

-(selectnumBtn *)btn3
{
    if(!_btn3)
    {
        _btn3 = [[selectnumBtn alloc] init];
        _btn3.backgroundColor = [UIColor whiteColor];
        _btn3.layer.masksToBounds = YES;
        _btn3.layer.cornerRadius = 5;
        _btn3.numlab.text = @"1500人";
        _btn3.numlab.textColor = [UIColor colorWithHexString:@"333333"];
        _btn3.selimg.image = [UIImage imageNamed:@"zb_oroom_pf"];
    }
    return _btn3;
}

-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.font = [UIFont systemFontOfSize:15];
        _lab4.textColor = [UIColor colorWithHexString:@"333333"];
        _lab4.text = @"推荐码";
    }
    return _lab4;
}

-(UIButton *)selectbtn
{
    if(!_selectbtn)
    {
        _selectbtn = [[UIButton alloc] init];
        [_selectbtn setImage:[UIImage imageNamed:@"zb_oroom_sel"] forState:normal];
    }
    return _selectbtn;
}




@end
