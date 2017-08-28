//
//  WeddingLiveTableCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WeddingLiveTableCell.h"
#import "WeddingLiveFutureCell.h"


@implementation WeddingLiveTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLiveFutureCell class]) bundle:nil] forCellWithReuseIdentifier:@"future"];
    _collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
