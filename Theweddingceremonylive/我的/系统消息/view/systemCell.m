//
//  systemCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "systemCell.h"

@interface systemCell()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UIView *topimg;
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *timelab;
@end

@implementation systemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.topimg];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.timelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.leftimg.sd_layout
    .leftSpaceToView(self.contentView,25*WIDTH_SCALE)
    .topSpaceToView(self.contentView,30*WIDTH_SCALE)
    .heightIs(30*WIDTH_SCALE)
    .widthEqualToHeight();
    
    weakSelf.topimg.sd_layout
    .leftSpaceToView(weakSelf.leftimg, 14*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 28*HEIGHT_SCALE)
    .rightSpaceToView(self.contentView, 14*WIDTH_SCALE)
    .heightIs(3*HEIGHT_SCALE);
    
    weakSelf.contentlab.sd_layout
    .leftEqualToView(weakSelf.topimg)
    .topSpaceToView(weakSelf.topimg, 3)
    .rightEqualToView(weakSelf.topimg)
    .autoHeightRatio(0);
    
    weakSelf.timelab.sd_layout
    .leftEqualToView(weakSelf.contentlab)
    .topSpaceToView(weakSelf.contentlab, 10)
    .rightEqualToView(weakSelf.contentlab)
    .heightIs(15*HEIGHT_SCALE);
    
    
   // [self setupAutoHeightWithBottomView:weakSelf.timelab bottomMargin:14*HEIGHT_SCALE];
    
    [self setupAutoHeightWithBottomViewsArray:@[weakSelf.contentlab,weakSelf.timelab] bottomMargin:20*HEIGHT_SCALE];
    
}

#pragma mark - getters


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"syscell"];
        _leftimg.layer.masksToBounds = YES;
        _leftimg.layer.cornerRadius = 15*WIDTH_SCALE;
    }
    return _leftimg;
}


-(UIView *)topimg
{
    if(!_topimg)
    {
        _topimg = [[UIView alloc] init];
        _topimg.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
    }
    return _topimg;
}

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        
    }
    return _bgview;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.text = @"北京地铁全线支持刷手机 苹果用户哭瞎北京地铁全线支持刷手机 苹果用户哭瞎北京地铁全线支持刷手机 苹果用户哭瞎北京地铁全线支持刷手机 苹果用户哭瞎北京地铁全线支持刷手机 苹果用户哭瞎北京地铁全线支持刷手机 苹果用户哭瞎";
        _contentlab.font = [UIFont systemFontOfSize:13];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        
    }
    return _contentlab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.font = [UIFont systemFontOfSize:12];
        _timelab.textColor = [UIColor colorWithHexString:@"999999"];
        NSString *str = @"1502850707";
        NSInteger inter = [str intValue];
        _timelab.text = [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    }
    return _timelab;
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
