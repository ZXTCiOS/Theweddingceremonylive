//
//  infoCell3.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoCell3.h"

@interface infoCell3()

@end

@implementation infoCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_offset(54*WIDTH_SCALE);
        make.height.mas_offset(14*HEIGHT_SCALE);
    }];
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftlab.mas_right).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(14*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"昵称";
        _leftlab.textColor = [UIColor colorWithHexString:@"999999"];
        _leftlab.font = [UIFont systemFontOfSize:14];
    }
    return _leftlab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.font = [UIFont systemFontOfSize:14];
        _contentlab.text = @"姓名姓名";
    }
    return _contentlab;
}



@end
