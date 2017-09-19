//
//  hengpingMaskView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "hengpingMaskView.h"

@interface hengpingMaskView ()

@property (weak, nonatomic) IBOutlet UIView *iconMask;



@end

@implementation hengpingMaskView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.iconMask.layer.cornerRadius = 18;
    self.iconMask.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 18;
    self.icon.layer.masksToBounds = YES;
    [self collectionView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.itemSize = CGSizeMake(36, 36);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(75, 16, kScreenW - 140 - 75, 36) collectionViewLayout:layout];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


@end
