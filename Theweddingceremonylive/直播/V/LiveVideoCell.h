//
//  LiveVideoCell.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPlayer.h"
#import "LiveVideoModel.h"

@interface LiveVideoCell : UITableViewCell

@property (nonatomic, strong) WMPlayer *player;

@property (nonatomic, strong) LiveVideoModel *model;

@end
