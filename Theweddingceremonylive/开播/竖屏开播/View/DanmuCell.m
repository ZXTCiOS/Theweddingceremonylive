//
//  DanmuCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "DanmuCell.h"

@implementation DanmuCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"text"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self textL];
    }
    return self;
}


- (UILabel *)textL{
    if (!_textL) {
        _textL = [[UILabel alloc] init];
                  //WithFrame:CGRectMake(0, 0, 260, 30)];
        _textL.font = [UIFont systemFontOfSize:14];
        _textL.textColor = [UIColor orangeColor];
        _textL.numberOfLines = 0;
        [self addSubview:_textL];
        [_textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(0);
        }];
    }
    return _textL;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
