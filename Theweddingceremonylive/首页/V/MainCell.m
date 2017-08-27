//
//  MainCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell


- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(_imgV.mas_width).multipliedBy(9 / 16.0);
        }];
        _imgV.layer.cornerRadius = 5;
        _imgV.layer.masksToBounds = YES;
    }
    return _imgV;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textColor = krgb(51, 51, 51, 1);
        [self addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.top.equalTo(self.imgV.mas_bottom).equalTo(10);
        }];
    }
    return _titleL;
}

@end
