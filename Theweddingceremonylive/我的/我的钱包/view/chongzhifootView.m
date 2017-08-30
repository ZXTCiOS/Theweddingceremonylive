//
//  chongzhifootView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chongzhifootView.h"

@interface chongzhifootView()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *typelab;

@end

@implementation chongzhifootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftlab];
        [self addSubview:self.moneytext];
        [self addSubview:self.typelab];
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.width.mas_offset(50*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    [weakSelf.moneytext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftlab.mas_right).with.offset(4*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-15*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.leftlab);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftlab);
        make.top.equalTo(weakSelf.leftlab.mas_bottom).with.offset(30*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"金额";
        _leftlab.textColor = [UIColor colorWithHexString:@"333333"];
        _leftlab.font = [UIFont systemFontOfSize:15];
        
    }
    return _leftlab;
}

-(UITextField *)moneytext
{
    if(!_moneytext)
    {
        _moneytext = [[UITextField alloc] init];
        _moneytext.placeholder = @"请输入充值金额";
    }
    return _moneytext;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.text = @"充值方式";
        _typelab.font = [UIFont systemFontOfSize:15];
    }
    return _typelab;
}

-(zhifuBtn *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[zhifuBtn alloc] init];
        
    }
    return _btn0;
}

-(zhifuBtn *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[zhifuBtn alloc] init];
        
    }
    return _btn1;
}



@end
