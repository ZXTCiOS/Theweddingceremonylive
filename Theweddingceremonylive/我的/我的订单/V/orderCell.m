//
//  orderCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderCell.h"

@interface orderCell()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *livetimelab;
@property (nonatomic,strong) UILabel *ordertimelab;
@property (nonatomic,strong) UIButton *setBtn;
@end

@implementation orderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.livetimelab];
        [self.contentView addSubview:self.ordertimelab];
        [self.contentView addSubview:self.setBtn];
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
        _livetimelab.font = [UIFont systemFontOfSize:13];
    }
    return _livetimelab;
}

-(UILabel *)ordertimelab
{
    if(!_ordertimelab)
    {
        _ordertimelab = [[UILabel alloc] init];
        _ordertimelab.textColor = [UIColor colorWithHexString:@"999999"];
        _ordertimelab.font = [UIFont systemFontOfSize:13];
    }
    return _ordertimelab;
}

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];
        [_setBtn setTitle:@"升级" forState:normal];
        _setBtn.layer.masksToBounds = YES;
        _setBtn.layer.cornerRadius = 4;
        _setBtn.backgroundColor = [UIColor colorWithHexString:@"e84c22"];
    }
    return _setBtn;
}





@end
