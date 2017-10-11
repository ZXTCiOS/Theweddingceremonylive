//
//  shopdetalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shopdetalisVC.h"
#import "shopdetalisCell0.h"
#import "shopdetalisCell1.h"
#import "shopdetalisCell2.h"

@interface shopdetalisVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *datadic;
@property (nonatomic,assign) BOOL guanzhu;
@end

static NSString *shopdetaliscellidentfid = @"shopdetaliscellidentfid";
static NSString *shopdetaliscellidentfid0 = @"shopdetaliscellidentfid0";
static NSString *shopdetaliscellidentfid1 = @"shopdetaliscellidentfid1";
static NSString *shopdetaliscellidentfid2 = @"shopdetaliscellidentfid2";

@implementation shopdetalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guanzhu = NO;
    // Do any additional setup after loading the view.
    self.title = @"商家详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关注" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    
    self.datadic = [NSDictionary dictionary];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
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
    NSDictionary *para = @{@"uid":uid,@"token":token,@"businid":self.businid};
    
    [DNNetworking postWithURLString:post_getbusininfo parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            self.datadic = [obj objectForKey:@"data"];
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *is_guanzhu = [dic objectForKey:@"is_guanzhu"];
            if ([is_guanzhu isEqualToString:@"0"]) {
                self.guanzhu = NO;
            }
            else
            {
                self.guanzhu = YES;
            }
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络失败" toView:self.view];
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}


#pragma mark -UITableViewDataSource&&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopdetaliscellidentfid];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopdetaliscellidentfid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.datadic objectForKey:@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        return cell;
    }
    if (indexPath.row==1) {
        shopdetalisCell0 *cell = [tableView dequeueReusableCellWithIdentifier:shopdetaliscellidentfid0];
        cell = [[shopdetalisCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopdetaliscellidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.datadic];
        return cell;
    }
    if (indexPath.row==2) {
        shopdetalisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:shopdetaliscellidentfid1];
        cell = [[shopdetalisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopdetaliscellidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.datadic];
        return cell;
    }
    if (indexPath.row==3) {
        shopdetalisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:shopdetaliscellidentfid2];
        cell = [[shopdetalisCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopdetaliscellidentfid2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 210*HEIGHT_SCALE;
    }
    if (indexPath.row==2) {
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
        
    }
    if (indexPath.row==3) {
        return 200*HEIGHT_SCALE;
    }
    return 0;
}

-(void)rightAction
{
    if (self.guanzhu) {
        
    }
    else
    {
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSDictionary *para = @{@"uid":uid,@"token":token,@"businid":self.businid};
        [DNNetworking postWithURLString:post_guanzhushangjia parameters:para success:^(id obj) {
            NSString *msg = [obj objectForKey:@"msg"];
            [MBProgressHUD showSuccess:msg toView:self.view];
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
        }];;
    }

    
}

#pragma mark - tabbar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


@end
