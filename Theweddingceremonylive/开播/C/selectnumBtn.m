//
//  selectnumBtn.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "selectnumBtn.h"

@implementation selectnumBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numlab];
        [self addSubview:self.selimg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.selimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(28*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-28*WIDTH_SCALE);
        
    }];
    
    [weakSelf.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.selimg.mas_bottom).with.offset(5*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc] init];
        _numlab.textAlignment = NSTextAlignmentCenter;
        _numlab.text = @"300人";
        _numlab.font = [UIFont systemFontOfSize:15];
    }
    return _numlab;
}

-(UIImageView *)selimg
{
    if(!_selimg)
    {
        _selimg = [[UIImageView alloc] init];
        _selimg.image = [UIImage imageNamed:@"zb_oroom_po"];
    }
    return _selimg;
}




@end
