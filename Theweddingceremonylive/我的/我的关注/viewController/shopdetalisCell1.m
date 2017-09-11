//
//  shopdetalisCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shopdetalisCell1.h"

@interface shopdetalisCell1()
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation shopdetalisCell1

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
    .topSpaceToView(weakSelf.contentView, 5*HEIGHT_SCALE)
    .leftSpaceToView(weakSelf.contentView, 10*WIDTH_SCALE)
    .rightSpaceToView(weakSelf.contentView, 10*WIDTH_SCALE)
    .autoHeightRatio(0);
    
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.font = [UIFont systemFontOfSize:15];
    }
    return _contentlab;
}

-(void)setdata:(NSDictionary *)dic
{
    NSString *content = [dic objectForKey:@"content"];
    self.contentlab.text = content;
    [self setupAutoHeightWithBottomView:self.contentlab bottomMargin:10*HEIGHT_SCALE];
    
}


@end
