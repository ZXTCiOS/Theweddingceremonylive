//
//  orderdetalisCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderdetalisCell.h"

@interface orderdetalisCell()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *pricelab;
@end

@implementation orderdetalisCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentlab addSubview:self.pricelab];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
}


#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _typelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:15];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _contentlab;
}


-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.font = [UIFont systemFontOfSize:14];
        _pricelab.textColor = [UIColor colorWithHexString:@"ED5E40"];
    }
    return _pricelab;
}




@end
