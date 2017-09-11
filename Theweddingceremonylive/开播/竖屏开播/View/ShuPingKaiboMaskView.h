//
//  ShuPingKaiboMaskView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuPingKaiboMaskView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *labelID;

@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// 底部 button
@property (weak, nonatomic) IBOutlet UIButton *closeBen;

@property (weak, nonatomic) IBOutlet UIButton *redbagBtn;

@property (weak, nonatomic) IBOutlet UIButton *lianmaiBtn;

@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;

@property (weak, nonatomic) IBOutlet UIButton *jingyinBtn;

@property (weak, nonatomic) IBOutlet UIButton *isBack;

// 输入框
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *send;

@property (weak, nonatomic) IBOutlet UIView *textFView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottemConstraint;








@end
