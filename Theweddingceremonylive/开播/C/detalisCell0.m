//
//  detalisCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisCell0.h"
#import "LLQImageView.h"

@interface detalisCell0()
@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) LLQImageView *bbsimg;
@end

@implementation detalisCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.bbsimg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.iconImg.sd_layout
    .leftSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 14*HEIGHT_SCALE)
    .widthIs(37*WIDTH_SCALE)
    .heightIs(37*WIDTH_SCALE);
    
    weakSelf.nameLab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 60*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 14*HEIGHT_SCALE)
    .widthIs(100*WIDTH_SCALE)
    .heightIs(20*HEIGHT_SCALE);
    
    weakSelf.timeLab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 60*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 37*HEIGHT_SCALE)
    .widthIs(150*WIDTH_SCALE)
    .heightIs(16*HEIGHT_SCALE);
    

}

#pragma mark - getters


-(UIImageView *)iconImg
{
    if(!_iconImg)
    {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 37/2*WIDTH_SCALE;

    }
    return _iconImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLab.font = [UIFont systemFontOfSize:15];
    }
    return _nameLab;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = [UIFont systemFontOfSize:10];
        _timeLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _timeLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _contentLab;
}

-(LLQImageView *)bbsimg
{
    if(!_bbsimg)
    {
        _bbsimg =  [[LLQImageView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
        
    }
    return _bbsimg;
}

-(void)setdata:(NSDictionary *)dic
{
    __weak typeof (self) weakSelf = self;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"picture"]]];
    self.nameLab.text = [dic objectForKey:@"name"];
    self.contentLab.text = [dic objectForKey:@"bbs_content"];
    NSInteger inter = [[dic objectForKey:@"bbs_addtime"] intValue];
    self.timeLab.text =  [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd"];
    
    NSArray *dataimg = [NSArray new];
    NSString *imgstr0 = [dic objectForKey:@"bbs_picture1"];
    NSString *imgstr1 = [dic objectForKey:@"bbs_picture2"];
    NSString *imgstr2 = [dic objectForKey:@"bbs_picture3"];
    
    //没有图
    if (imgstr0.length==0) {
        dataimg = [[NSArray alloc] init];
    }
    
    //只有图1
    if (imgstr0.length!=0&&imgstr1.length==0) {
        dataimg = [[NSArray alloc] init];
        
        dataimg = @[imgstr0];
    }
    
    //图1和图2
    if (imgstr2.length==0&&imgstr1.length!=0) {
        dataimg = [[NSArray alloc] init];
        dataimg = @[imgstr0,imgstr1];
        
    }
    
    //图1 图2 图3
    if (imgstr2.length!=0) {
        dataimg = [NSMutableArray array];
        dataimg = @[imgstr0,imgstr1,imgstr2];
        
    }
    weakSelf.contentLab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .rightSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 60*HEIGHT_SCALE)
    .autoHeightRatio(0);
    UIView *bottomview = [UIView new];
    if (dataimg.count==0) {
        bottomview = self.contentLab;
    }
    else
    {
        _bbsimg.data = dataimg;
        weakSelf.bbsimg.sd_layout
        .leftSpaceToView(weakSelf.contentView, 50*WIDTH_SCALE)
        .topSpaceToView(weakSelf.contentLab, 20*HEIGHT_SCALE)
        .heightIs(75*WIDTH_SCALE)
        .widthIs(75*3*WIDTH_SCALE+20*WIDTH_SCALE);
        bottomview = self.bbsimg;
    }
    [self setupAutoHeightWithBottomView:bottomview bottomMargin:40*HEIGHT_SCALE];
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
