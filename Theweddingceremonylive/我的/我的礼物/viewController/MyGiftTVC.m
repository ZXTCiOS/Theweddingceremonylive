//
//  MyGiftTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyGiftTVC.h"
#import "MyGiftCell.h"
#import "infoVC.h"
#import "GiftModel.h"

@interface MyGiftTVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation MyGiftTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的礼物";
    pn = 1;
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.table.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    pn = 1;
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *page = [NSString stringWithFormat:@"%d",pn];
    NSDictionary *paradic = @{@"uid":uid,@"token":token,@"page":page};
    [DNNetworking postWithURLString:post_getgift parameters:paradic success:^(id obj) {
        NSLog(@"obj---%@",obj);
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                GiftModel *model = [[GiftModel alloc] init];
                model.towuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"towuid"]];
                model.picture = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]];
                model.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                model.gift_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gift_name"]];
                model.pigurl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pigurl"]];
                model.count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
                [self.dataSource addObject:model];
            }
        }
        [self.table reloadData];
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
        [self.table.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn ++;
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *page = [NSString stringWithFormat:@"%d",pn];
    NSDictionary *paradic = @{@"uid":uid,@"token":token,@"page":page};
    [DNNetworking postWithURLString:post_getgift parameters:paradic success:^(id obj) {
        NSLog(@"obj---%@",obj);
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                GiftModel *model = [[GiftModel alloc] init];
                model.towuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"towuid"]];
                model.picture = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]];
                model.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                model.gift_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gift_name"]];
                model.pigurl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pigurl"]];
                model.count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
                [self.dataSource addObject:model];
            }
        }
        [self.table reloadData];
        [self.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
        [self.table.mj_footer endRefreshing];
    }];
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
    return self.dataSource.count;
//    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[MyGiftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*HEIGHT_SCALE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    infoVC *vc = [[infoVC alloc] init];
    GiftModel *model = self.dataSource[indexPath.row];
    vc.useruid = model.towuid;
    [self.navigationController pushViewController:vc animated:YES];
}



//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//
//}
@end
