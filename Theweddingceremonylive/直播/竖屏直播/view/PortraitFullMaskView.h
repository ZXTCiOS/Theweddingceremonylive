//
//  PortraitFullMaskView.h
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitAudienceView.h"
#import "PortraitChatView.h"


typedef void(^myblock)();

@interface PortraitFullMaskView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *user_img;


@property (weak, nonatomic) IBOutlet UILabel *user_name;


@property (weak, nonatomic) IBOutlet UILabel *user_id;


@property (weak, nonatomic) IBOutlet UILabel *countL;


@property (weak, nonatomic) IBOutlet PortraitChatView *tableView;


@property (weak, nonatomic) IBOutlet PortraitAudienceView *collectionView;



@property (nonatomic, copy) myblock first;


@property (nonatomic, copy) myblock second;


@property (nonatomic, copy) myblock third;


@property (nonatomic, copy) myblock fourth;

@property (nonatomic, copy) myblock fifth;

@property (nonatomic, copy) myblock icon;





@end

