//
//  bbsCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bbsCell.h"
#import "FSCustomButton.h"

@interface bbsCell()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) FSCustomButton *dianBtn;
@end

@implementation bbsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.namelab];
//        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
//        [self.contentView addSubview:self.img0];
//        [self.contentView addSubview:self.img1];
//        [self.contentView addSubview:self.img2];
//        [self.contentView addSubview:self.dianBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.iconimg.sd_layout
    .leftSpaceToView(self.contentView,10*WIDTH_SCALE)
    .topSpaceToView(self.contentView,14*WIDTH_SCALE)
    .heightIs(28*WIDTH_SCALE)
    .widthIs(28*WIDTH_SCALE);
    
    weakSelf.namelab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 49*WIDTH_SCALE)
    .topEqualToView(weakSelf.iconimg)
    .heightIs(20*HEIGHT_SCALE).autoWidthRatio(4);
    
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 49*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 56*HEIGHT_SCALE)
    .widthIs(kScreenW-14*WIDTH_SCALE-49*WIDTH_SCALE)
    .autoHeightRatio(0);
    
    
//    
    [self setupAutoHeightWithBottomViewsArray:@[weakSelf.contentlab,weakSelf.namelab] bottomMargin:20*HEIGHT_SCALE];
}

#pragma mark - getters

-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
        [_iconimg sd_setImageWithURL:[NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/u=913836838,411507439&fm=26&gp=0.jpg"]];
        _iconimg.backgroundColor = [UIColor orangeColor];
    }
    return _iconimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor colorWithHexString:@"333333"];
        _namelab.font = [UIFont systemFontOfSize:15];
        _namelab.text = @"姓名姓名";
    }
    return _namelab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor colorWithHexString:@"999999"];
        _timelab.text = @"2017.09.01";
        _timelab.font = [UIFont systemFontOfSize:15];
    }
    return _timelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:14];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.text = @"2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网";
    }
    return _contentlab;
}

-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        
    }
    return _img1;
}

-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        
    }
    return _img2;
}

-(FSCustomButton *)dianBtn
{
    if(!_dianBtn)
    {
        _dianBtn = [[FSCustomButton alloc] init];
        [_dianBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_dianBtn setTitle:@"12" forState:normal];
        _dianBtn.adjustsTitleTintColorAutomatically = YES;
        [_dianBtn setTitleColor:[UIColor colorWithHexString:@"c7c7cd"] forState:normal];
        _dianBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _dianBtn.titleEdgeInsets = UIEdgeInsetsMake(8*HEIGHT_SCALE, 0, 0, 0);
        _dianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_dianBtn addTarget:self action:@selector(dianBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dianBtn;
}

-(void)dianBtnclick
{
    
}

@end
