//
//  hengpingWatchMaskView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myblock)();
@interface hengpingWatchMaskView : UIView



@property (weak, nonatomic) IBOutlet UIImageView *user_img;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_id;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *textFView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *send;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;




@property (weak, nonatomic) IBOutlet UIButton *leaveMeeting;
@property (nonatomic, copy) myblock first;
@property (nonatomic, copy) myblock second;
@property (nonatomic, copy) myblock third;
@property (nonatomic, copy) myblock fourth;
@property (nonatomic, copy) myblock fifth;
@property (nonatomic, copy) myblock icon;

// 分享 view
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIButton *QQ;
@property (weak, nonatomic) IBOutlet UIButton *Wechat;
@property (weak, nonatomic) IBOutlet UIButton *Pengyouquan;


@end
