//
//  perfectingCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectingCell1.h"
#import "selectBtn.h"

@interface perfectingCell1()
@property (nonatomic,strong) UILabel *lab;
@property (nonatomic,strong) selectBtn *selbtn0;
@property (nonatomic,strong) selectBtn *selbtn1;
@end

@implementation perfectingCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab];
        [self.contentView addSubview:self.selbtn0];
        [self.contentView addSubview:self.selbtn1];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(100*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    [self.selbtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        make.width.mas_offset(100*WIDTH_SCALE);
    }];
    [self.selbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selbtn0.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        make.width.mas_offset(100*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.textColor = [UIColor colorWithHexString:@"333333"];
        _lab.font = [UIFont systemFontOfSize:16];
        _lab.text = @"性别";
    }
    return _lab;
}

-(selectBtn *)selbtn0
{
    if(!_selbtn0)
    {
        _selbtn0 = [[selectBtn alloc] init];
        _selbtn0.setLab.text = @"男";
        _selbtn0.setImg.image = [UIImage imageNamed:@"yesimg"];
    }
    return _selbtn0;
}


-(selectBtn *)selbtn1
{
    if(!_selbtn1)
    {
        _selbtn1 = [[selectBtn alloc] init];
        _selbtn1.setLab.text = @"女";
        _selbtn1.setImg.image = [UIImage imageNamed:@"noimg"];
    }
    return _selbtn1;
}



@end
