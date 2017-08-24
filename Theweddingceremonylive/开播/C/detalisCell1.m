//
//  detalisCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisCell1.h"
#import "detalisModel.h"

@interface detalisCell1()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) detalisModel *dmodel;
@end

@implementation detalisCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;

    weakSelf.bgview.sd_layout
    .leftSpaceToView(weakSelf.contentView, 12*WIDTH_SCALE)
    .rightSpaceToView(weakSelf.contentView, 12*WIDTH_SCALE)
    .topEqualToView(weakSelf.contentView)
    .bottomEqualToView(weakSelf.contentView);
    
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .rightSpaceToView(weakSelf.contentView, 16*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 5*HEIGHT_SCALE)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:weakSelf.contentlab bottomMargin:5*HEIGHT_SCALE];
    
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    }
    return _bgview;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.font = [UIFont systemFontOfSize:12];

    }
    return _contentlab;
}

-(void)setdata:(detalisModel *)model
{
    self.dmodel = model;
    
    if (model.user2infouid.length==0) {
        NSString *str1 = model.user1infoname;
        NSString *str2 = @"回复";
        NSString *str4 = [NSString stringWithFormat:@"%@%@",@":",model.bbs_content];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",str1,str2,str4]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"576b95"] range:NSMakeRange(0,str1.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length,str2.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length+str2.length,str4.length)];
        self.contentlab.attributedText = str;

    }
    else
    {
        NSString *str1 = model.user1infoname;
        NSString *str2 = @"回复";
        NSString *str3 = model.user2infoname;
        NSString *str4 = [NSString stringWithFormat:@"%@%@",@":",model.bbs_content];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"576b95"] range:NSMakeRange(0,str1.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length,str2.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"576b95"] range:NSMakeRange(str1.length+str2.length,str3.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length+str2.length+str3.length,str4.length)];
        
        self.contentlab.attributedText = str;
    }
}

@end
