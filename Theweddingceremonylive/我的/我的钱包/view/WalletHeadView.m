//
//  WalletHeadView.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "WalletHeadView.h"


#define imgWidth 120
#define imgToTop 20
#define balenceFont 40
#define balanceToImg 20
#define labFont 16
#define labToBalance 20
#define labToBottom 30


@implementation WalletHeadView



- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect f = CGRectMake(0, 0, kScreenW, (imgToTop + imgWidth + balanceToImg + balenceFont + labToBalance + labFont + labToBottom));
    self = [super initWithFrame:f];
    if (self) {
        [self balanceL];
        [self lab];
        [self imgV];
    }
    return self;
}

- (UILabel *)balanceL{
    if (!_balanceL) {
        
        _balanceL = [[UILabel alloc] init];
        _balanceL.font = kFont(balenceFont);
        [self addSubview:_balanceL];
        [_balanceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.imgV.mas_bottom).equalTo(balanceToImg);
            make.size.equalTo(CGSizeMake(kScreenW, balenceFont));
        }];
        _balanceL.textAlignment = NSTextAlignmentCenter;
    }
    return _balanceL;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        _imgV.image = [UIImage imageNamed:@"my_walet_xq"];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(imgToTop);
            make.size.equalTo(CGSizeMake(imgWidth, imgWidth));
        }];
    }
    return _imgV;
}

- (UILabel *)lab{
    if (!_lab) {
        _lab = [[UILabel alloc] init];
        [self addSubview:_lab];
        _lab.text = @"账户余额（元）";
        _lab.textColor = [UIColor darkGrayColor];
        _lab.font = kFont(labFont);
        [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.balanceL.mas_bottom).equalTo(labToBalance);
            
        }];
        [_lab sizeToFit];
        
    }
    return _lab;
}


@end
