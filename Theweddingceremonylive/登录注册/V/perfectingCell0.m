//
//  perfectingCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectingCell0.h"

@interface perfectingCell0()

@end

@implementation perfectingCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab];
        [self.contentView addSubview:self.text];
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
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab.mas_left);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
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
    }
    return _lab;
}

-(UITextField *)text
{
    if(!_text)
    {
        _text = [[UITextField alloc] init];
    }
    return _text;
}



@end
