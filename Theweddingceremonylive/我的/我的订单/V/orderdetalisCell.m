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
        _typelab.text = @"房间类型";
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
    NSString *typestr = [dic objectForKey:@"pattern"];
    if ([typestr isEqualToString:@"1"]) {
    
        self.contentlab.text = @"免费亲友内部直播";
        [self.pricelab setHidden:YES];
    }
    if ([typestr isEqualToString:@"2"]) {
        NSString *room_count = [dic objectForKey:@"room_count"];
        if ([room_count isEqualToString:@"300"]) {
            self.contentlab.text = @"旗舰款";
            self.pricelab.text = @"399";
        }
        if ([room_count isEqualToString:@"500"]) {

            self.contentlab.text = @"旗舰款";
            self.pricelab.text = @"520";
        }
        if ([room_count isEqualToString:@"1000"]) {

            self.contentlab.text = @"旗舰款";
            self.pricelab.text = @"999";
        }
        if ([room_count isEqualToString:@"1500"]) {
           
            self.contentlab.text = @"旗舰款";
            self.pricelab.text = @"1314";
        }

        
    }
    if ([typestr isEqualToString:@"3"]) {
        NSString *room_count = [dic objectForKey:@"room_count"];
        if ([room_count isEqualToString:@"5000"]) {

            self.contentlab.text = @"公众人物直播";
            self.pricelab.text = @"2999";
        }
        if ([room_count isEqualToString:@"10000"]) {
   
            self.contentlab.text = @"公众人物直播";
            self.pricelab.text = @"3999";
        }
    }
}

@end
