//
//  wanshanCell4.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wanshanCell4.h"

@implementation wanshanCell4

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.wanshantext];
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
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
    }];
    [weakSelf.wanshantext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab.mas_right).with.offset(4*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.font = [UIFont systemFontOfSize:15];
    }
    return _typelab;
}

-(UITextField *)wanshantext
{
    if(!_wanshantext)
    {
        _wanshantext = [[UITextField alloc] init];
        UILabel * placeholderLabel = [_wanshantext valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentRight;
    }
    return _wanshantext;
}





@end
