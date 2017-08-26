//
//  cardimgView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "cardimgView.h"

@implementation cardimgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addBtn];
        [self addSubview:self.cardlab];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.addBtn.frame = CGRectMake(self.frame.size.width/2-12*WIDTH_SCALE, 25*HEIGHT_SCALE, 24*WIDTH_SCALE, 24*WIDTH_SCALE);
    self.cardlab.frame = CGRectMake(10*WIDTH_SCALE, 60*HEIGHT_SCALE, self.frame.size.width-20*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"zb_smrz_btn"] forState:normal];
    }
    return _addBtn;
}


-(UILabel *)cardlab
{
    if(!_cardlab)
    {
        _cardlab = [[UILabel alloc] init];
        _cardlab.textColor = [UIColor colorWithHexString:@"999999"];
        _cardlab.font = [UIFont systemFontOfSize:15];
        _cardlab.textAlignment = NSTextAlignmentCenter;
    }
    return _cardlab;
}



@end
