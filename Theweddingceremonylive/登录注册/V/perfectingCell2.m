//
//  perfectingCell2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectingCell2.h"

@interface perfectingCell2()
@property (nonatomic,strong) UILabel *lab;
@property (nonatomic,strong) UIButton *setBtn;
@end

@implementation perfectingCell2
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab];
        [self.contentView addSubview:self.setBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(70*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-70*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(50*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.text = @"您的真实姓名平台会绝对保密，仅有收到您礼物的亲友可以看到";
        _lab.textColor = [UIColor colorWithHexString:@"E95F46"];
        _lab.font = [UIFont systemFontOfSize:12];
    }
    return _lab;
}

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn= [[UIButton alloc] init];
        [_setBtn setTitle:@"完成" forState:normal];
        _setBtn.backgroundColor = [UIColor colorWithHexString:@"E95F46"];
        [_setBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _setBtn.layer.masksToBounds = YES;
        _setBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _setBtn;
}




@end
