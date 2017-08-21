//
//  postCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postCell0.h"

@interface postCell0()
@property (nonatomic,strong) UILabel *leftLab;

@end

@implementation postCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLab];
        [self.contentView addSubview:self.titletext];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10*HEIGHT_SCALE);
        make.width.mas_offset(60*WIDTH_SCALE);
    }];
    [self.titletext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftLab.mas_right).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.leftLab);
        make.bottom.equalTo(weakSelf.leftLab);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.text = @"标题:";
        _leftLab.font = [UIFont systemFontOfSize:17];
        _leftLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _leftLab;
}

-(UITextField *)titletext
{
    if(!_titletext)
    {
        _titletext = [[UITextField alloc] init];
        _titletext.placeholder = @"请输入标题";
    }
    return _titletext;
}

@end
