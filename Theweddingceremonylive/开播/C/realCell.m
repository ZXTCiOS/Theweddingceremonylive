//
//  realCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realCell.h"

@interface realCell()
@property (nonatomic,strong) UIView *lineview;
@end

@implementation realCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLab];
        [self.contentView addSubview:self.lineview];
        [self.contentView addSubview:self.realText];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
    }];
    [weakSelf.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftLab.mas_right);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
        make.width.mas_offset(1);
    }];
    [weakSelf.realText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftLab.mas_right);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.leftLab);
        make.bottom.equalTo(weakSelf.leftLab);
    }];
}

#pragma mark - getters

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = [UIFont systemFontOfSize:15];
        _leftLab.textColor = [UIColor colorWithHexString:@"333333"];
        _leftLab.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLab;
}

-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    }
    return _lineview;
}

-(UITextField *)realText
{
    if(!_realText)
    {
        _realText = [[UITextField alloc] init];
        
    }
    return _realText;
}





@end
