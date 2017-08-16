//
//  modifyCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "modifyCell.h"

@interface modifyCell()
@property (nonatomic,strong) UIButton *setbtn;
@end

@implementation modifyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.setbtn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.setbtn.frame = CGRectMake(kScreenW/2-120*WIDTH_SCALE, 20*HEIGHT_SCALE, 240*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

#pragma mark - getters


-(UIButton *)setbtn
{
    if(!_setbtn)
    {
        _setbtn = [[UIButton alloc] init];
        [_setbtn setTitle:@"完成" forState:normal];
        [_setbtn setTitleColor:[UIColor whiteColor] forState:normal];
        _setbtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _setbtn.layer.masksToBounds = YES;
        _setbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_setbtn addTarget:self action:@selector(setbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setbtn;
}

-(void)setbtnclick
{
    [self.delegate submitbtnClick:self];
}

@end
