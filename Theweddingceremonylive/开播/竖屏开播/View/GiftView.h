//
//  GiftView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

typedef NS_ENUM(NSUInteger, screenDirection) {
    screenDirectionV,
    screenDirectionH,
};

@interface GiftView : UIView

@property (nonatomic, assign) screenDirection direction;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageC;
@property (nonatomic, strong) UIButton *send;
@property (nonatomic, strong) UIButton *chongzhi;
@property (nonatomic, strong) UIButton *number;
@property (nonatomic, strong) UILabel *yuE;


@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic, strong) NSArray<NSArray *> *giftlist;



- (instancetype)initWithDirection:(screenDirection) direction;

@end
