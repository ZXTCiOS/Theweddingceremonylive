//
//  MyGiftCell.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyGiftCell.h"

@interface MyGiftCell()
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *numlab;
@property (nonatomic,strong) UIImageView *rightImg;
@end


@implementation MyGiftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.numlab];
        [self.contentView addSubview:self.rightImg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(18*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(28*WIDTH_SCALE);
        make.height.mas_offset(28*WIDTH_SCALE);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.height.mas_offset(15*HEIGHT_SCALE);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(14*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_offset(17*WIDTH_SCALE);
        make.height.mas_offset(17*WIDTH_SCALE);
    }];
    [self.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.rightImg);
        make.right.equalTo(weakSelf.rightImg.mas_left).with.offset(18*WIDTH_SCALE);
        make.height.mas_offset(17*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        [_leftImg sd_setImageWithURL:[NSURL URLWithString:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg"]];
        _leftImg.layer.masksToBounds = YES;
        _leftImg.layer.cornerRadius = 14*WIDTH_SCALE;
    }
    return _leftImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"姓名姓名礼物";
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLab;
}

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc] init];
        _numlab.textColor = [UIColor colorWithHexString:@"333333"];
        _numlab.text = @"12";
        _numlab.font = [UIFont systemFontOfSize:20];
        _numlab.textAlignment = NSTextAlignmentRight;
    }
    return _numlab;
}

-(UIImageView *)rightImg
{
    if(!_rightImg)
    {
        _rightImg = [[UIImageView alloc] init];
        [_rightImg sd_setImageWithURL:[NSURL URLWithString:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg"]];
    }
    return _rightImg;
}





@end
