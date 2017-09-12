//
//  PortraitFullMaskView.h
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^myblock)();

@interface PortraitFullMaskView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *user_img;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_id;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *textFView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *send;



@property (weak, nonatomic) IBOutlet UIButton *leaveMeeting;
@property (nonatomic, copy) myblock first;
@property (nonatomic, copy) myblock second;
@property (nonatomic, copy) myblock third;
@property (nonatomic, copy) myblock fourth;
@property (nonatomic, copy) myblock fifth;
@property (nonatomic, copy) myblock icon;

// 分享 view
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIControl *QQ;
@property (weak, nonatomic) IBOutlet UIControl *Wechat;
@property (weak, nonatomic) IBOutlet UIControl *Pengyouquan;



@end

