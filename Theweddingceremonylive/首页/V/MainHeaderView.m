//
//  MainHeaderView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainHeaderView.h"

@interface MainHeaderView ()

@property (nonatomic, strong) UIImageView *img;



@end


@implementation MainHeaderView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self img];
        [self title];
    }
    return self;
}


- (UIControl *)mask{
    if (!_mask) {
        _mask = [[UIControl alloc] init];
        [self addSubview:_mask];
        [_mask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(0);
        }];
    }
    return _mask;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = krgb(51, 51, 51, 1);
        [self.mask addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(100, 20));
        }];
    }
    return _title;
}

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        [self.mask addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(6, 8));
        }];
        _img.image = [UIImage imageNamed:@""];
    }
    return _img;
}






@end
