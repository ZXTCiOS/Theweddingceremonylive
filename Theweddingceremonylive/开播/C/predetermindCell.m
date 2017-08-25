//
//  predetermindCell.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "predetermindCell.h"

@interface predetermindCell()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIImageView *imageViewPwd;
@end

@implementation predetermindCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.predetext];
        [self.contentView addSubview:self.lineview];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.predetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
    }];
    
    [weakSelf.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.predetext);
        make.right.equalTo(weakSelf.predetext);
        make.top.equalTo(weakSelf.predetext.mas_bottom);
        make.height.mas_offset(1);
    }];
}

#pragma mark - getters

-(UITextField *)predetext
{
    if(!_predetext)
    {
        _predetext = [[UITextField alloc] init];
        _imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 24, 24)];
        _imageViewPwd.image=[UIImage imageNamed:@"zb_oroom_key"];
        _predetext.leftView=_imageViewPwd;
        _predetext.delegate = self;
        _predetext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    }
    return _predetext;
}


-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lineview;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length==0) {
        _imageViewPwd.image=[UIImage imageNamed:@"zb_oroom_key"];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"999999"];
        _predetext.leftView=_imageViewPwd;
    }
    else
    {
        _imageViewPwd.image=[UIImage imageNamed:@"zb_oroom_key_s"];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _predetext.leftView=_imageViewPwd;
    }
    return YES;
}
@end
