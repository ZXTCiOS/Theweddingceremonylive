//
//  infoCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoCell0.h"

@interface infoCell0()
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *idLab;
@end

@implementation infoCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.userImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.idLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(kScreenW/2-30*WIDTH_SCALE);
        make.width.mas_offset(60*WIDTH_SCALE);
        make.height.mas_offset(60*WIDTH_SCALE);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userImg.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-kScreenW/2+5*WIDTH_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
    }];
    [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab);
        make.left.equalTo(weakSelf).with.offset(kScreenW/2+5*WIDTH_SCALE);
        make.height.mas_offset(14*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)userImg
{
    if(!_userImg)
    {
        _userImg = [[UIImageView alloc] init];
        [_userImg sd_setImageWithURL:[NSURL URLWithString:@"http://www.qqpk.cn/Article/UploadFiles/201110/20111020102349724.jpg"]];
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.cornerRadius = 30*WIDTH_SCALE;
    }
    return _userImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentRight;
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.text = @"姓名姓名";
    }
    return _nameLab;
}

-(UILabel *)idLab
{
    if(!_idLab)
    {
        _idLab = [[UILabel alloc] init];
        _idLab.textColor = [UIColor colorWithHexString:@"666666"];
        _idLab.font = [UIFont systemFontOfSize:12];
        _idLab.text = @"id-666";
    }
    return _idLab;
}

@end
