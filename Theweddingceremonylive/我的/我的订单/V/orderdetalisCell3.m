//
//  orderdetalisCell3.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderdetalisCell3.h"

@interface orderdetalisCell3()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) UILabel *lab2;
@end

@implementation orderdetalisCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.pricelab];
        [self.contentView addSubview:self.lab2];
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
//    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.typelab.mas_right).with.offset(10*WIDTH_SCALE);
//        make.top.equalTo(weakSelf.typelab);
//        
//    }];
//    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
//        make.top.equalTo(weakSelf.typelab);
//    }];
    
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.typelab, 10*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 10*HEIGHT_SCALE)
    .rightSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .autoHeightRatio(0);
    

    
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:15];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
        _typelab.text = @"推荐之选";
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


-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.font = [UIFont systemFontOfSize:14];
        _lab2.textColor = [UIColor colorWithHexString:@"333333"];
 
    }
    return _lab2;
}



-(void)setData:(NSDictionary *)dic
{
   // NSDictionary *goodsdic = [dic objectForKey:@"goods_tuijian"];
    NSArray *goods_tuijianarr = [dic objectForKey:@"goods_tuijian"];
    NSMutableArray *infoarr = [NSMutableArray array];
    NSMutableArray *pricearr = [NSMutableArray array];
    
    for (int i = 0; i<goods_tuijianarr.count; i++) {
        NSDictionary *dic = [goods_tuijianarr objectAtIndex:i];
        [infoarr addObject:[dic objectForKey:@"info"]];
        [pricearr addObject:[dic objectForKey:@"money"]];
    }
    NSString *infostr = [infoarr componentsJoinedByString:@","];
    
    self.contentlab.text = infostr;
    
    __weak typeof (self) weakSelf = self;
    weakSelf.lab2.sd_layout
    .leftSpaceToView(weakSelf.contentView, 15*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentlab, 5*HEIGHT_SCALE)
    .widthIs(100*WIDTH_SCALE)
    .heightIs(20*HEIGHT_SCALE);
    
    weakSelf.pricelab.sd_layout
    .rightSpaceToView(weakSelf.contentView, 15*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentlab, 5*HEIGHT_SCALE)
    .widthIs(150*WIDTH_SCALE)
    .heightIs(20*HEIGHT_SCALE);
    
    _lab2.text = @"价格";

    NSNumber *sum = [pricearr valueForKeyPath:@"@sum.floatValue"];
    NSString *moneystr = [NSString stringWithFormat:@"%@",sum];
    self.pricelab.text = moneystr;
    [self setupAutoHeightWithBottomView:self.pricelab bottomMargin:10*HEIGHT_SCALE];
    
}


@end
