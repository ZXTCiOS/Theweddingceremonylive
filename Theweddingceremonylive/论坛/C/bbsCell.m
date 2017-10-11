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
#import "bbsModel.h"

@interface bbsCell()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) FSCustomButton *dianBtn;
@property (nonatomic,strong) LLQImageView *bbsimg;
@property (nonatomic,strong) bbsModel *bmodel;
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
    .autoWidthRatio(3);

    
    weakSelf.timelab.sd_layout
    .leftSpaceToView(weakSelf.namelab, 2*WIDTH_SCALE)
    .topEqualToView(weakSelf.iconimg)
    .heightIs(20*HEIGHT_SCALE)
    .rightSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE);
    
}

#pragma mark - getters

-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
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
    }
    return _namelab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor colorWithHexString:@"999999"];
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
    }
    return _contentlab;
}

-(FSCustomButton *)dianBtn
{
    if(!_dianBtn)
    {
        _dianBtn = [[FSCustomButton alloc] init];
        [_dianBtn setImage:[UIImage imageNamed:@"forum_sz_s"] forState:UIControlStateNormal];
        [_dianBtn setTitle:@"0" forState:normal];
        _dianBtn.adjustsTitleTintColorAutomatically = YES;
        [_dianBtn setTitleColor:[UIColor colorWithHexString:@"c7c7cd"] forState:normal];
        _dianBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _dianBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _dianBtn.titleLabel.font = [UIFont systemFontOfSize:15];
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

-(void)setdata:(bbsModel *)model
{
    self.bmodel = model;
    self.namelab.text = model.name;
    self.timelab.text = model.bbs_addtime;
    [self.iconimg sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@""]];
    self.contentlab.text = model.bbs_title;
    if ([model.is_point isEqualToString:@"0"]) {
         [_dianBtn setImage:[UIImage imageNamed:@"forum_sz"] forState:UIControlStateNormal];
    }
    else
    {
         [_dianBtn setImage:[UIImage imageNamed:@"forum_sz_s"] forState:UIControlStateNormal];
    }
    
    [self.dianBtn setTitle:model.bbs_thumbs forState:normal];
    NSInteger inter = [model.bbs_addtime intValue];
    self.timelab.text = [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd"];
    NSArray *dataimg = [NSArray new];
    //没有图
    if (model.bbs_picture1.length==0) {
        dataimg = [[NSArray alloc] init];
    }
    
    //只有图1
    if (model.bbs_picture1.length!=0&&model.bbs_picture2.length==0) {
        dataimg = [[NSArray alloc] init];
       
        dataimg = @[model.bbs_picture1];
    }
    
    //图1和图2
    if (model.bbs_picture3.length==0&&model.bbs_picture2.length!=0) {
        dataimg = [[NSArray alloc] init];
        dataimg = @[model.bbs_picture1,model.bbs_picture2];
        
    }
    
    //图1 图2 图3
    if (model.bbs_picture3.length!=0) {
        dataimg = [NSMutableArray array];
        dataimg = @[model.bbs_picture1,model.bbs_picture2,model.bbs_picture3];

    }
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 49*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 56*HEIGHT_SCALE)
    .widthIs(kScreenW-14*WIDTH_SCALE-49*WIDTH_SCALE)
    .autoHeightRatio(0);
    
    UIView *bottomview = [UIView new];
    if (dataimg.count==0) {
        weakSelf.dianBtn.sd_layout
        .rightSpaceToView(weakSelf.contentView, 12*WIDTH_SCALE)
        .topSpaceToView(weakSelf.contentlab, 36*HEIGHT_SCALE)
        .heightIs(30*HEIGHT_SCALE)
        .widthIs(40*WIDTH_SCALE);
        
        bottomview = self.dianBtn;
    }
    else
    {
        _bbsimg.data = dataimg;
        weakSelf.bbsimg.sd_layout
        .leftSpaceToView(weakSelf.contentView, 50*WIDTH_SCALE)
        .topSpaceToView(weakSelf.contentlab, 20*HEIGHT_SCALE)
        .heightIs(75*WIDTH_SCALE)
        .widthIs(75*3*WIDTH_SCALE+20*WIDTH_SCALE);
        
        weakSelf.dianBtn.sd_layout
        .rightSpaceToView(weakSelf.contentView, 12*WIDTH_SCALE)
        .topSpaceToView(weakSelf.bbsimg, 36*HEIGHT_SCALE)
        .heightIs(30*HEIGHT_SCALE)
        .widthIs(40*WIDTH_SCALE);
        
        bottomview = self.dianBtn;
        
    }
    
    [self setupAutoHeightWithBottomView:bottomview bottomMargin:20*HEIGHT_SCALE];
    
//    [self setupAutoHeightWithBottomViewsArray:@[weakSelf.contentlab,weakSelf.namelab,weakSelf.bbsimg,weakSelf.dianBtn] bottomMargin:20*HEIGHT_SCALE];
}

-(void)dianBtnclick
{
    [self.delegate bbspointbtnClick:self];
}

#pragma mark - 将某个时间戳转化成 时间

-(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //format = @"YYYY-MM-dd hh:mm:ss";
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


@end
