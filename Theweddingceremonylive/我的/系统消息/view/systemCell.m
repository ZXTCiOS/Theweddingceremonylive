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
        [self addSubview:self.timelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    
}

#pragma mark - getters


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"syscell"];
    }
    return _leftimg;
}


-(UIView *)topimg
{
    if(!_topimg)
    {
        _topimg = [[UIView alloc] init];
        
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
        
    }
    return _contentlab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        
    }
    return _timelab;
}









@end
