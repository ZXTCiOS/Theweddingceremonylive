//
//  wanshanCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wanshanCell1.h"

@interface wanshanCell1()
@property (nonatomic,strong) UILabel *typelab;
@end

@implementation wanshanCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.typelab];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(60*HEIGHT_SCALE);
        make.width.mas_offset(105*WIDTH_SCALE);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
        
    }];
    
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"wanshanleft1"];
    }
    return _leftImg;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"直播间封面图片上传";
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _typelab;
}



@end
