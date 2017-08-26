//
//  infoCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoCell.h"

@implementation infoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 25;
    self.imgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
