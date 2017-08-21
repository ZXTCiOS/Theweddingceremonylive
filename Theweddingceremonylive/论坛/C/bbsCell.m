//
//  bbsCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bbsCell.h"
#import "FSCustomButton.h"
#import "LLQImageView.h"

@interface bbsCell()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;

@property (nonatomic,strong) FSCustomButton *dianBtn;

@property (nonatomic,strong) LLQImageView *bbsimg;
@end

@implementation bbsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.dianBtn];
        [self.contentView addSubview:self.bbsimg];
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
    .heightIs(20*HEIGHT_SCALE)
    .autoWidthRatio(4);
    
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 49*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 56*HEIGHT_SCALE)
    .widthIs(kScreenW-14*WIDTH_SCALE-49*WIDTH_SCALE)
    .autoHeightRatio(0);
    
    weakSelf.timelab.sd_layout
    .leftSpaceToView(weakSelf.namelab, 2*WIDTH_SCALE)
    .topEqualToView(weakSelf.iconimg)
    .heightIs(20*HEIGHT_SCALE)
    .autoWidthRatio(4);
    
    NSArray *data = @[@"http://pic7.nipic.com/20100609/3143623_160732828380_2.jpg",
                      @"http://pic7.nipic.com/20100609/3143623_160732828380_2.jpg"
                      ];
    _bbsimg.data = data;
    weakSelf.bbsimg.sd_layout
    .leftSpaceToView(weakSelf.contentView, 50*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentlab, 20*HEIGHT_SCALE)
    .heightIs(75*WIDTH_SCALE)
    .widthIs(75*3*WIDTH_SCALE+20*WIDTH_SCALE);
    
    weakSelf.dianBtn.sd_layout.rightSpaceToView(weakSelf.contentView, 12*WIDTH_SCALE).topSpaceToView(weakSelf.bbsimg, 8*HEIGHT_SCALE).heightIs(12*HEIGHT_SCALE).widthIs(60*WIDTH_SCALE);
    
    [self setupAutoHeightWithBottomViewsArray:@[weakSelf.contentlab,weakSelf.namelab,weakSelf.bbsimg,weakSelf.dianBtn] bottomMargin:20*HEIGHT_SCALE];
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
        _contentlab.text = @"2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网2017中国网球公开赛于9月在北京挥拍。强劲的参赛阵容，实力超群的网坛巨星，群芳争艳闪耀中网,";
    }
    return _contentlab;
}

-(FSCustomButton *)dianBtn
{
    if(!_dianBtn)
    {
        _dianBtn = [[FSCustomButton alloc] init];
        [_dianBtn setImage:[UIImage imageNamed:@"forum_sz_s"] forState:UIControlStateNormal];
        [_dianBtn setTitle:@"12" forState:normal];
        _dianBtn.adjustsTitleTintColorAutomatically = YES;
        [_dianBtn setTitleColor:[UIColor colorWithHexString:@"c7c7cd"] forState:normal];
        _dianBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _dianBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _dianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_dianBtn addTarget:self action:@selector(dianBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dianBtn;
}

-(LLQImageView *)bbsimg
{
    if(!_bbsimg)
    {
        _bbsimg =  [[LLQImageView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
        
    }
    return _bbsimg;
}

-(void)dianBtnclick
{
    
}

@end
