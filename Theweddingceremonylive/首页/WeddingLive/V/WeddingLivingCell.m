//
//  WeddingLivingCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WeddingLivingCell.h"

@implementation WeddingLivingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.imgV.layer.cornerRadius = 8;
    self.imgV.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
