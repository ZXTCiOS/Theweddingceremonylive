//
//  reflectCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "reflectCell.h"

@implementation reflectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.reflectext];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [weakSelf.reflectext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftlab.mas_right).with.offset(5*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textColor = [UIColor colorWithHexString:@"333333"];
        _leftlab.font = [UIFont systemFontOfSize:15];
    }
    return _leftlab;
}

-(UITextField *)reflectext
{
    if(!_reflectext)
    {
        _reflectext = [[UITextField alloc] init];
        
    }
    return _reflectext;
}




@end
