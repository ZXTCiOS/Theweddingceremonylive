//
//  wanshanCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wanshanCell0.h"

@interface wanshanCell0()
@property (nonatomic,strong) UILabel *lab0;

@end

@implementation wanshanCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.wanshantext];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
    }];
    [weakSelf.wanshantext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right).with.offset(4*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc]init];
        _lab0.text = @"房间名称";
        _lab0.textColor = [UIColor colorWithHexString:@"333333"];
        _lab0.font = [UIFont systemFontOfSize:15];
    }
    return _lab0;
}

-(UITextField *)wanshantext
{
    if(!_wanshantext)
    {
        _wanshantext = [[UITextField alloc] init];
        _wanshantext.placeholder = @"请输入房间名称";
        UILabel * placeholderLabel = [_wanshantext valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentRight;
    }
    return _wanshantext;
}





@end
