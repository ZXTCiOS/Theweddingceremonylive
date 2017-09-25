//
//  PreLiveView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "PreLiveView.h"

@implementation PreLiveView





- (UIButton *)switchCamera{
    if (!_switchCamera) {
        _switchCamera = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_switchCamera];
        UIImage *image = [UIImage imageNamed:@"zb_qiehuan"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_switchCamera setImage:image forState:UIControlStateNormal];
        [_switchCamera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.cancel.mas_centerY);
            make.right.equalTo(self.switchScreen.mas_left).equalTo(-8);
        }];
    }
    return _switchCamera;
}

- (UIButton *)switchScreen{
    if (!_switchScreen) {
        _switchScreen = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_switchScreen];
        [_switchScreen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.cancel.mas_centerY);
            make.right.equalTo(self.cancel.mas_left).equalTo(-8);
        }];
        UIImage *image = [UIImage imageNamed:@"zb_tiyan_qiehuan"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_switchScreen setImage:image forState:UIControlStateNormal];
    }
    return _switchScreen;
}

- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_cancel];
        [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.top.equalTo(22);
            make.right.equalTo(-8);
        }];
        UIImage *image = [UIImage imageNamed:@"zb_close"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_cancel setImage:image forState:UIControlStateNormal];
    }
    return _cancel;
}

- (UITextField *)title{
    if (!_title) {
        _title = [[UITextField alloc] init];
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(100);
            make.left.equalTo(10);
            make.size.equalTo(CGSizeMake(300, 50));
        }];
        _title.font = [UIFont systemFontOfSize:30];
    }
    return _title;
}

- (UIButton *)kaishi{
    if (!_kaishi) {
        _kaishi = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_kaishi];
        [_kaishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(200, 50));
            make.bottom.equalTo(-80);
            make.centerX.equalTo(0);
        }];
        [_kaishi setTitle:@"我要直播" forState: UIControlStateNormal];
        _kaishi.titleLabel.textColor = [UIColor whiteColor];
        [_kaishi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_kaishi setBackgroundColor:[UIColor orangeColor]];
        _kaishi.layer.cornerRadius = 25;
        _kaishi.layer.masksToBounds = YES;
    }
    return _kaishi;
}



@end
