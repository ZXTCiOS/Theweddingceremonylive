//
//  orderCell2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderCell2.h"

@interface orderCell2()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *livetimelab;
@property (nonatomic,strong) UILabel *ordertimelab;

@end


@implementation orderCell2


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.livetimelab];
        [self.contentView addSubview:self.ordertimelab];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(18*HEIGHT_SCALE);
        make.width.mas_offset(104*WIDTH_SCALE);
        make.height.mas_offset(60*HEIGHT_SCALE);
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_offset(120*WIDTH_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
    }];
    [self.livetimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.namelab);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
    }];
    [self.ordertimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.namelab.mas_top).with.offset(2*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
    }];

}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.backgroundColor = [UIColor orangeColor];
    }
    return _leftimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"直播间的名字";
        _namelab.font = [UIFont systemFontOfSize:15];
        _namelab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _namelab;
}

-(UILabel *)livetimelab
{
    if(!_livetimelab)
    {
        _livetimelab = [[UILabel alloc] init];
        _livetimelab.textColor = [UIColor colorWithHexString:@"999999"];
        _livetimelab.font = [UIFont systemFontOfSize:11];
        _livetimelab.text = @"直播时间 2017-08-17 10:25:20";
    }
    return _livetimelab;
}

-(UILabel *)ordertimelab
{
    if(!_ordertimelab)
    {
        _ordertimelab = [[UILabel alloc] init];
        _ordertimelab.textColor = [UIColor colorWithHexString:@"999999"];
        _ordertimelab.font = [UIFont systemFontOfSize:11];
        _ordertimelab.text = @"2017-08-17 10:25:20";
        _ordertimelab.textAlignment = NSTextAlignmentRight;
    }
    return _ordertimelab;
}


@end
