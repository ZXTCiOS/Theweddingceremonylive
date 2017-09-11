//
//  shopdetalisCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shopdetalisCell0.h"

@interface shopdetalisCell0()
@property (nonatomic,strong) UIImageView *img;
@end

@implementation shopdetalisCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.img];
   
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.img.frame = CGRectMake(10*WIDTH_SCALE, 10*HEIGHT_SCALE, kScreenW-20*WIDTH_SCALE, 190*HEIGHT_SCALE);
    
}

#pragma mark - getters

-(UIImageView *)img
{
    if(!_img)
    {
        _img = [[UIImageView alloc] init];
    }
    return _img;
}

-(void)setdata:(NSDictionary *)dic
{
    NSString *picurl = [dic objectForKey:@"picurl"];
    [self.img sd_setImageWithURL:[NSURL URLWithString:picurl]];
}

@end
