//
//  changeCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeCell0.h"

@interface changeCell0()
@property (nonatomic,strong) UIView *line;
@end

@implementation changeCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typeLab];
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.line];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeLab.mas_right);
        make.top.equalTo(weakSelf).with.offset(6);
        make.bottom.equalTo(weakSelf).with.offset(-6);
        make.width.mas_offset(1);
    }];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).with.offset(5*WIDTH_SCALE);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters


-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textAlignment = NSTextAlignmentCenter;
        _typeLab.font = [UIFont systemFontOfSize:15];
        _typeLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _typeLab;
}

-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    }
    return _line;
}

-(UITextField *)text
{
    if(!_text)
    {
        _text = [[UITextField alloc] init];
        _text.keyboardType = UIKeyboardTypePhonePad;
    }
    return _text;
}





@end
