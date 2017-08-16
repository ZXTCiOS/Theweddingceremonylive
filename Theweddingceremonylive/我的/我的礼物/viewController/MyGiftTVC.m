//
//  MyGiftTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyGiftTVC.h"
#import "MyGiftCell.h"

@interface MyGiftTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

@implementation MyGiftTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的礼物";
    [self.view addSubview:self.table];
//    [XDFactory addBackItemForVC:self];
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.tableFooterView = [UIView new];
    UINib *nib = [UINib nibWithNibName:@"MyGiftCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"cell"];
    MJWeakSelf
    [self.table addHeaderRefresh:^{
        [weakSelf.table endHeaderRefresh];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    /*cell.giftImage.image =
    cell.giftName.text = @"";
    cell.giftNum.text = [NSString stringWithFormat:@"%d个", 100];
    cell.giftSender.text = @"";*/
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.hidesBottomBarWhenPushed = YES;
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//
//}
@end
