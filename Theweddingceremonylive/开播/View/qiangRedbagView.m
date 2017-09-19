//
//  qiangRedbagView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "qiangRedbagView.h"


@interface qiangRedbagView ()

@property (nonatomic, strong) UIView *redView;


@end


@implementation qiangRedbagView



- (instancetype)init{
    self = [super initWithFrame:CGRectMake((kScreenW - 220)/2, (kScreenH-310)/2, 220, 370)];
    if (self) {
        [self redView];
        [self from];
        [self money];
        [self sucess];
        [self detail];
        [self cancel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




- (UILabel *)from{
    if (!_from) {
        _from = [[UILabel alloc] init];
        [self addSubview:_from];
        [_from mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(30);
            make.centerX.equalTo(0);
            make.left.right.equalTo(0);
            make.height.equalTo(14);
        }];
        _from.textColor = krgb(247, 213, 144, 1);
        _from.font = [UIFont systemFontOfSize:14];
        _from.textAlignment = NSTextAlignmentCenter;
        _from.backgroundColor = krgb(237, 94, 64, 1);
    }
    return _from;
}

- (UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc] init];
        [self addSubview:_money];
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.from.mas_bottom).equalTo(40);
            make.left.right.equalTo(0);
            make.height.equalTo(28);
        }];
        _money.textColor = krgb(247, 213, 144, 1);
        _money.font = [UIFont systemFontOfSize:35];
        _money.textAlignment = NSTextAlignmentCenter;
        _money.backgroundColor = krgb(237, 94, 64, 1);
    }
    return _money;
}

- (UILabel *)sucess{
    if (!_sucess) {
        _sucess = [[UILabel alloc] init];
        [self addSubview:_sucess];
        [_sucess mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            
            make.top.equalTo(self.money.mas_bottom).equalTo(20);
            make.height.equalTo(12);
        }];
        _sucess.textColor = krgb(247, 213, 144, 1);
        _sucess.font = [UIFont systemFontOfSize:12];
        _sucess.textAlignment = NSTextAlignmentCenter;
        _sucess.backgroundColor = krgb(237, 94, 64, 1);
    }
    return _sucess;
}

- (UIButton *)detail{
    if (!_detail) {
        _detail = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_detail];
        [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.height.equalTo(75);
            make.bottom.equalTo(self.redView.mas_bottom).equalTo(0);
        }];
        [_detail setTitle:@"领取详情" forState: UIControlStateNormal];
        [_detail setTitleColor:krgb(247, 213, 144, 1) forState:UIControlStateNormal];
        _detail.titleLabel.font = [UIFont systemFontOfSize:15];
        [_detail setBackgroundImage:[UIImage imageNamed:@"zb_tc_hu"] forState:UIControlStateNormal];
        _detail.backgroundColor = [UIColor clearColor];
    }
    return _detail;
}

- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_cancel];
        [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(45, 45));
        }];
        [_cancel setBackgroundImage:[UIImage imageNamed:@"zb_tc_close"] forState:UIControlStateNormal];
        [_cancel setTitle:@"" forState:UIControlStateNormal];
        _cancel.backgroundColor = [UIColor clearColor];
    }
    return _cancel;
}

- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        [self addSubview:_redView];
        [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(310);
        }];
        _redView.backgroundColor = krgb(237, 94, 64, 1);
    }
    return _redView;
}








@end
