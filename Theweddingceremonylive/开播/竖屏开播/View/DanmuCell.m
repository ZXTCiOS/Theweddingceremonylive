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
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"danmu"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self textL];
    }
    return self;
}


- (UILabel *)textL{
    if (!_textL) {
        _textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 260, 30)];
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
