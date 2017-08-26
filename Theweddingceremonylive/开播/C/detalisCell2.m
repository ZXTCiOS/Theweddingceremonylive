//
//  detalisCell2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisCell2.h"

@implementation detalisCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab.sd_layout
    .leftSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .rightSpaceToView(weakSelf.contentView, 14*WIDTH_SCALE)
    .topSpaceToView(weakSelf.contentView, 15*HEIGHT_SCALE)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:weakSelf.contentlab bottomMargin:15*HEIGHT_SCALE];
}

#pragma mark - getters


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



@end
