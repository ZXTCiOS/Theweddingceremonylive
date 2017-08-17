//
//  mineCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell0.h"

@interface mineCell0()

@end

@implementation mineCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.typeLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(24*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(18*HEIGHT_SCALE);
        make.width.mas_offset(18*WIDTH_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(16*WIDTH_SCALE);
        make.top.equalTo(weakSelf.leftImg);
        make.height.mas_offset(15*HEIGHT_SCALE);
        make.width.mas_offset(120*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        
    }
    return _leftImg;
}

-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab = [[UILabel alloc] init];
        
    }
    return _typeLab;
}




@end
