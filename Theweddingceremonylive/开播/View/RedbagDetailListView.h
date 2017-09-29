//
//  RedbagDetailListView.h
//  Theweddingceremonylive
//
//  Created by apple on 17/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedBagModel.h"

@interface RedbagDetailListView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray<RedBagModel *> *datalist;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *redbagID;

@property (weak, nonatomic) IBOutlet UIImageView *imaV;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *last;
@property (weak, nonatomic) IBOutlet UIButton *cancel;







- (void)netWorking;



@end
