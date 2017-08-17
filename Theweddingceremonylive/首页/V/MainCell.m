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
        }];
    }
    return _imgV;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        [self addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.top.equalTo(self.imgV.mas_bottom).equalTo(10);
        }];
    }
    return _titleL;
}

@end
