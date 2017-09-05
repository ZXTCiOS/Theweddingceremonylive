//
//  orderCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderCell.h"
#import "orderModel.h"

@interface orderCell()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *livetimelab;
@property (nonatomic,strong) UILabel *ordertimelab;
@property (nonatomic,strong) UIButton *setBtn;
@property (nonatomic,strong) orderModel *omodel;
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
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-8*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-11*HEIGHT_SCALE);
        make.height.mas_offset(28*HEIGHT_SCALE);
        make.width.mas_offset(60*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];

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

        _ordertimelab.textAlignment = NSTextAlignmentRight;
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
        _setBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _setBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_setBtn addTarget:self action:@selector(setbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

-(void)setbtnclick
{
    [self.delegate submitbtnClick:self];
}

-(void)setdata:(orderModel *)model
{
    self.omodel = model;
    [self.leftimg sd_setImageWithURL:[NSURL URLWithString:model.room_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
    self.namelab.text = model.room_name;
    NSInteger ordertimeinteger = [model.ordertime integerValue];
    self.ordertimelab.text = [self timestampSwitchTime:ordertimeinteger andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    NSInteger livetimeinteger = [model.create_time integerValue];
    NSString *livestr = [self timestampSwitchTime:livetimeinteger andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    self.livetimelab.text = [NSString stringWithFormat:@"%@%@",@"直播时间:",livestr];
    
    
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
