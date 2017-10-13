//
//  NvwaHeaderView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "NvwaHeaderView.h"


@interface NvwaHeaderView ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *grayV;
@end



@implementation NvwaHeaderView



- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, 35 + (kScreenW - 40) *9 / 16.0 + 5)];
    if (self) {
        
        [self imgV];
        [self redView];
        [self grayV];
        [self mask];
        [self title];
        [self isZhibo];
        [self whiteView];
        [self control];
    }
    return self;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        
        _imgV.frame = CGRectMake(20, 35, kScreenW - 40, (kScreenW - 40) * 9 / 16.0);
        /*
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.top.equalTo(35);
            //make.bottom.equalTo(-5);
            make.height.equalTo(kScreenW - 40).multipliedBy(9/16);
        }];*/
        _imgV.contentMode = UIViewContentModeScaleToFill;
        [_imgV.layer masksToBounds];
    }
    return _imgV;
}

- (UIView *)grayV{
    if (!_grayV) {
        _grayV = [[UIView alloc] init];
        [self addSubview:_grayV];
        [_grayV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(8);
            
        }];
        _grayV.backgroundColor = krgb(242, 242, 242, 1);
    }
    return _grayV;
}

- (UIView *)mask{
    if (!_mask) {
        _mask = [[UIView alloc] init];
        [self addSubview:_mask];
        [_mask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.imgV);
            make.height.equalTo(25);
            make.bottom.equalTo(- 5);
        }];
        _mask.backgroundColor = [UIColor blackColor];
        _mask.alpha = 0.6;
    }
    return _mask;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [self.mask addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.right.greaterThanOrEqualTo(10);
            make.centerY.equalTo(0);
            make.height.equalTo(25);
        }];
        _title.font = [UIFont systemFontOfSize:12];
        _title.textColor = [UIColor whiteColor];
    }
    return _title;
}

- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        [self addSubview:_redView];
        [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(45);
            make.right.equalTo(0);
            make.size.equalTo(CGSizeMake(75, 20));
        }];
        _redView.backgroundColor = krgb(237, 94, 64, 1);
        _redView.layer.cornerRadius = 10;
        _redView.layer.masksToBounds = YES;
    }
    return _redView;
}

- (UILabel *)isZhibo{
    if (!_isZhibo) {
        _isZhibo = [UILabel new];
        [self.redView addSubview:_isZhibo];
        [_isZhibo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.height.equalTo(20);
            make.width.equalTo(90);
            make.left.equalTo(8);
        }];
        _isZhibo.font = [UIFont systemFontOfSize:12];
        _isZhibo.textColor = [UIColor whiteColor];
    }
    return _isZhibo;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [UIView new];
        [self addSubview:_whiteView];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.redView);
            make.right.equalTo(0);
            make.left.equalTo(self.imgV.mas_right);
            make.height.equalTo(40);
        }];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc] init];
        [self addSubview:_control];
        [_control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(0);
        }];
    }
    return _control;
}












@end
