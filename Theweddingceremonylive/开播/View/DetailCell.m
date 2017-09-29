//
//  DetailCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        [self addSubview:_name];
        _name.textColor = krgb(51, 51, 51, 1);
        _name.font = kFont(12);
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgV.mas_right).equalTo(8);
            make.top.equalTo(2);
            make.bottom.equalTo(-2);
            make.right.equalTo(self.money.mas_left);
        }];
    }
    return _name;
}

- (UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc] init];
        [self addSubview:_money];
        _money.textColor = krgb(51, 51, 51, 1);
        _money.font = kFont(12);
        _money.textAlignment = NSTextAlignmentRight;
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.top.equalTo(2);
            make.bottom.equalTo(-2);
            make.width.equalTo(50);
        }];
    }
    return _money;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(3);
            make.left.equalTo(8);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        _imgV.layer.cornerRadius = 15;
        _imgV.layer.masksToBounds = YES;
    }
    return _imgV;
}










- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
