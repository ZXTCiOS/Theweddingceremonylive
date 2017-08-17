//
//  MyWalletTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyWalletTVC.h"
#import "WalletHeadView.h"


@interface MyWalletTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

@implementation MyWalletTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [XDFactory addBackItemForVC:self];
    self.navigationItem.title = @"我的钱包";
    
    [self.view addSubview:self.table];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] bk_initWithTitle:@"交易记录" style:UIBarButtonItemStylePlain handler:^(id sender) {
        // 交易记录
        NSLog(@"交易记录");
    }];
    item1.tintColor = [UIColor colorWithHexString:@"E95F46"];
    self.navigationItem.rightBarButtonItem = item1;
    
    WalletHeadView *walletV = [[WalletHeadView alloc] initWithFrame:CGRectZero];
    walletV.backgroundColor = [UIColor whiteColor];
    walletV.balanceL.text = [NSString stringWithFormat:@"%.2f" , 100.0f];
    self.table.tableHeaderView = walletV;
    self.table.tableFooterView = [UIView new];
    self.table.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getters

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (!indexPath.section) {
        cell.imageView.image = [UIImage imageNamed:@"touxiang"];
        cell.textLabel.text = @"充值";
    } else {
        cell.imageView.image = [UIImage imageNamed:@"touxiang"];
        cell.textLabel.text = @"提现";
    }
    cell.textLabel.font = kFont(18);
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.section) {
        
        NSLog(@"充值");
    } else {
        
        NSLog(@"提现");
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
