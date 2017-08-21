//
//  postCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postCell1.h"
#import "FCSmallImageViewController.h"

@interface postCell1()



@end

@implementation postCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.submitBtn];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.imgBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.height.mas_offset(100*HEIGHT_SCALE);
    }];
    
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textView);
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(50*WIDTH_SCALE);
        make.height.mas_offset(50*WIDTH_SCALE);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgBtn);
        make.top.equalTo(weakSelf.imgBtn);
        make.height.mas_offset(50*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-120*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"说点什么吧...";
    }
    return _textView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"提交" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 2;
    }
    return _submitBtn;
}

-(UIButton *)imgBtn
{
    if(!_imgBtn)
    {
        _imgBtn = [[UIButton alloc] init];
        [_imgBtn setImage:[UIImage imageNamed:@"forum_pic"] forState:normal];
        [_imgBtn addTarget:self action:@selector(imgclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgBtn;
}

-(UIView *)imgView
{
    if(!_imgView)
    {
        _imgView = [[UIView alloc] init];

    }
    return _imgView;
}

-(void)imgclick
{
    
    FCSmallImageViewController *smallVC = [[FCSmallImageViewController alloc]init];
    smallVC.maxSelect = 3;
    smallVC.returnBlock = ^(NSArray *imageArr){
        
        [_imgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [obj removeFromSuperview];
        }];
        [imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10*(idx+1)+80*idx, 0, 80, 80)];
            image.image = obj;
            [_imgView addSubview:image];
        }];
    };
//     [self.navigationController pushViewController:smallVC animated:YES];
}
@end
