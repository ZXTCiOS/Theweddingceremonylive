//
//  keyboardView.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "keyboardView.h"

@implementation keyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textview];
        [self addSubview:self.sendbtn];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textview.frame = CGRectMake(5, 16, kScreenW-65, 30);
    self.sendbtn.frame = CGRectMake(kScreenW-14-40, 10, 40, 40);
}

#pragma mark - getters

-(WJGtextView *)textview
{
    if(!_textview)
    {
        _textview = [[WJGtextView alloc] init];
        
    }
    return _textview;
}

-(UIButton *)sendbtn
{
    if(!_sendbtn)
    {
        _sendbtn = [[UIButton alloc] init];
        [_sendbtn setTitle:@"回复" forState:normal];
        _sendbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendbtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
    }
    return _sendbtn;
}



@end
