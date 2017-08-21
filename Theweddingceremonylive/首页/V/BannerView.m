//
//  BannerView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BannerView.h"

@interface BannerView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BannerView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self ic];
    
}

#pragma mark iCarousel delegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(carousel:didSelectItemAtIndex:)]) {
        return[_delegate iCarousel:carousel didSelectedAtIndex:index];
    }
}
/*
- (void)carouselDidEndDecelerating:(iCarousel *)carousel{
    __block NSInteger index = carousel.currentItemIndex;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer * _Nonnull timer) {
        
        if (index == [_datasource numberOfItemsInCarouselOfBannerView:self] - 1) {
            index = 0;
        }
        index++;
        self.ic.currentItemIndex = index;
    } repeats:NO];
    
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self.timer invalidate];
}
*/

#pragma mark iCarousel datasource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    if ([_datasource respondsToSelector:@selector(numberOfItemsInCarouselOfBannerView:)]) {
        return [_datasource numberOfItemsInCarouselOfBannerView:self];
    }
    return 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - 40, (kScreenW - 40)*9/16)];
    }
    if ([_datasource respondsToSelector:@selector(urlForItemAtIndex:)]) {
        [(UIImageView *)view sd_setImageWithURL:[NSURL URLWithString:[_datasource urlForItemAtIndex:index]] placeholderImage:[UIImage imageNamed:@"loginlogo"]];
    }
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

- (void)reloadData{
    
    [self.ic reloadData];
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
        [self.ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
    } repeats:YES];
}

- (IBAction)weddingVideo:(id)sender {
    
    NSLog(@"婚礼视频");
}

- (IBAction)weddingLive:(id)sender {
    
    NSLog(@"婚礼直播");
}

- (IBAction)nvwa:(id)sender {
    
    NSLog(@"女娲");
}

- (IBAction)tuijian:(id)sender {
    
    NSLog(@"推荐");
}

- (IBAction)more:(id)sender {
    
    NSLog(@"更多");
}







- (iCarousel *)ic{
    if (!_ic) {
        _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 4 / 7)];
        [self addSubview:_ic];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.type = 1;
        _ic.bounces = YES;
        _ic.pagingEnabled = YES;
        
    }
    return _ic;
}


@end
