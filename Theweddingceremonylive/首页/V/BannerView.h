//
//  BannerView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@class BannerView;
@protocol BannerViewDelegate <NSObject>

- (void)iCarousel:(iCarousel *)ic didSelectedAtIndex:(NSInteger) index;

@end

@protocol BannerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInCarouselOfBannerView:(BannerView *) banner;

- (NSString *)urlForItemAtIndex:(NSInteger) index;

@end


@interface BannerView : UICollectionReusableView<iCarouselDelegate, iCarouselDataSource>


@property (nonatomic, strong) iCarousel *ic;






@property (nonatomic, weak) id<BannerViewDelegate> delegate;
@property (nonatomic, weak) id<BannerViewDataSource> datasource;

- (void)reloadData;


@end
