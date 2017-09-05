//
//  MyWalletTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyWalletTVC.h"
#import "WalletHeadView.h"
#import "walletrecordVC.h"
#import "rechargeVC.h"
#import "reflectVC.h"

@interface MyWalletTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSString *user_wallet;
@property (nonatomic,strong) WalletHeadView *walletV;
@end

@implementation MyWalletTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [XDFactory addBackItemForVC:self];
    self.navigationItem.title = @"我的钱包";
    
    [self.view addSubview:self.table];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] bk_initWithTitle:@"交易记录" style:UIBarButtonItemStylePlain handler:^(id sender) {
        // 交易记录
        NSLog(@"交易记录");
        walletrecordVC *vc = [[walletrecordVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    item1.tintColor = [UIColor colorWithHexString:@"E95F46"];
    self.navigationItem.rightBarButtonItem = item1;
    
    self.walletV = [[WalletHeadView alloc] initWithFrame:CGRectZero];
    self.walletV.backgroundColor = [UIColor whiteColor];

    self.walletV.balanceL.text = self.user_wallet;
    self.table.tableHeaderView = self.walletV;
    self.table.tableFooterView = [UIView new];
    self.table.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_wallet parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.user_wallet = [dic objectForKey:@"user_wallet"];
            self.walletV.balanceL.text = self.user_wallet;

        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
    
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
        cell.imageView.image = [UIImage imageNamed:@"my_walet_rech"];
        
        cell.textLabel.text = @"充值";
    } else {
        cell.imageView.image = [UIImage imageNamed:@"my_walet_wdr"];
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
        rechargeVC *vc = [[rechargeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"提现");
        reflectVC *vc = [[reflectVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
