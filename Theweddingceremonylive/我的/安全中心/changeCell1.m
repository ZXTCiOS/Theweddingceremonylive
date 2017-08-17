//
//  changeCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeCell1.h"
#import "QCCountdownButton.h"
@interface changeCell1()
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) QCCountdownButton *sentCodeBtn;
@end

@implementation changeCell1
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typeLab];
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.sentCodeBtn];
        //进度b
        [self.sentCodeBtn processBlock:^(NSUInteger second) {
            self.sentCodeBtn.title = [NSString stringWithFormat:@"(%lis)后重新获取", second] ;
        } onFinishedBlock:^{  // 倒计时完毕
            self.sentCodeBtn.title = @"重新获取验证码";
        }];
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
    [self.sentCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(260*WIDTH_SCALE);
        make.right.equalTo(weakSelf.text.mas_right);
        make.top.equalTo(weakSelf.text.mas_top).with.offset(5*HEIGHT_SCALE);
        make.height.mas_offset(35*HEIGHT_SCALE);
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

- (QCCountdownButton *)sentCodeBtn{
    if(_sentCodeBtn == nil){
        _sentCodeBtn = [[QCCountdownButton alloc]init];
        [_sentCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        // 字体
        _sentCodeBtn.titleLabelFont = [UIFont systemFontOfSize:13];
        // 普通状态下的背景颜色
        _sentCodeBtn.nomalBackgroundColor = [UIColor colorWithHexString:@"E95F46"];
        // 失效状态下的背景颜色
        _sentCodeBtn.disabledBackgroundColor = [UIColor grayColor];
        // 倒计时的时长
        _sentCodeBtn.totalSecond = KTime;
        _sentCodeBtn.layer.masksToBounds = YES;
        _sentCodeBtn.layer.cornerRadius = 35/2*HEIGHT_SCALE;
        [_sentCodeBtn addTarget:self action:@selector(sendcodebtnclock) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sentCodeBtn;
}

-(void)sendcodebtnclock
{
    [self.delegate submitbtnClick:self];
}


@end
