//
//  tuijianRuseView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBLoopScrollView.h"


@interface tuijianRuseView : UICollectionReusableView

@property (nonatomic, strong) HYBLoopScrollView *loopV;

@property (nonatomic, assign) void(^block)(NSInteger atIndex);

@end
