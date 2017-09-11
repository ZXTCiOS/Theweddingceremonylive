//
//  AudienceCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "AudienceCell.h"

@implementation AudienceCell




- (instancetype)init{
    self = [super init];
    if (self) {
        [self img];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:_img];
        _img.layer.cornerRadius = 20;
        _img.layer.masksToBounds = YES;
    }
    return _img;
}




@end
