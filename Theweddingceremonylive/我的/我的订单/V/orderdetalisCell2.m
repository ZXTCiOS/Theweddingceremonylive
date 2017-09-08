//
//  orderdetalisCell2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderdetalisCell2.h"

@interface orderdetalisCell2()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *pricelab;

@end

@implementation orderdetalisCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.pricelab];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
        
    }];
    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
    }];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.text = @"一生珍藏";
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
        _pricelab.textAlignment = NSTextAlignmentRight;
    }
    return _pricelab;
}

-(void)setData:(NSDictionary *)dic
{
    NSDictionary *goodsdic = [dic objectForKey:@"goods"];
    NSString *type = [goodsdic objectForKey:@"type"];
    if ([type isEqualToString:@"1"]) {
        _pricelab.text = [goodsdic objectForKey:@"money"];
        _contentlab.text = [goodsdic objectForKey:@"info"];
        _typelab.text = @"礼盒装";
        
    }
    if ([type isEqualToString:@"2"]) {
        _pricelab.text = [goodsdic objectForKey:@"money"];
        _contentlab.text = [goodsdic objectForKey:@"info"];
        _typelab.text = @"高清版";
        
    }
    if ([type isEqualToString:@"3"]) {
        _pricelab.text = [goodsdic objectForKey:@"money"];
        _contentlab.text = [goodsdic objectForKey:@"info"];
        _typelab.text = @"高清 无弹幕 无水印";
        
    }
    
}
@end
