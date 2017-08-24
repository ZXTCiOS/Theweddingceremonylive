//
//  NvWaTuiJianCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "NvWaTuiJianCell.h"

@implementation NvWaTuiJianCell

    
    
    
    
- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200) style:UITableViewStylePlain];
        [self.contentView addSubview:_tableV];
        [_tableV registerNib:[UINib nibWithNibName:NSStringFromClass([LiebiaoCell class]) bundle:nil] forCellReuseIdentifier:@"liebiao"];
    }
    return _tableV;
}
    
    
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self tableV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
