//
//  hengpingWatchMaskView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "hengpingWatchMaskView.h"



@interface hengpingWatchMaskView ()

@property (weak, nonatomic) IBOutlet UIControl *info;


@end
@implementation hengpingWatchMaskView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.user_img.layer.cornerRadius = 18;
    self.user_img.layer.masksToBounds = YES;
    self.info.layer.cornerRadius = 18;
    self.info.layer.masksToBounds = YES;
    [self collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.itemSize = CGSizeMake(36, 36);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(22, 70, 36, kScreenW - 70 - 60) collectionViewLayout:layout];
        [self addSubview:_collectionView];
        
    }
    return _collectionView;
}







#pragma mark - 底部 5个 button

- (IBAction)sendMsg:(id)sender {
    !_first ?: _first();
}


- (IBAction)second:(id)sender {
    !_second ?: _second();
}


- (IBAction)third:(id)sender {
    !_third ?: _third();
}


- (IBAction)forth:(id)sender {
    !_fourth ?: _fourth();
}


- (IBAction)fifth:(id)sender {
    !_fifth ?: _fifth();
}


/**
 点击头像
 
 @param sender btn
 */
- (IBAction)userInfo:(id)sender {
    
}









- (IBAction)QQ:(id)sender {
}

- (IBAction)Wechat:(id)sender {
}

- (IBAction)Pengyouquan:(id)sender {
}
@end
