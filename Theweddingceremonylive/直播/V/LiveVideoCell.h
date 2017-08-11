//
//  LiveVideoCell.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LiveVideoCell : UITableViewCell

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, copy) NSString *url;

@property (weak, nonatomic) IBOutlet UIImageView *pause;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (weak, nonatomic) IBOutlet UIButton *list;
@property (weak, nonatomic) IBOutlet UIButton *share;


@end
