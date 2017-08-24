//
//  hotVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "hotVC.h"
#import "bbsCell.h"
#import "detalisVC.h"
#import "DemoTableViewController.h"
#import "bbsModel.h"

@interface hotVC ()<UITableViewDataSource,UITableViewDelegate,mybbsVdelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *hotidentfid = @"hotidentfid";

@implementation hotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    pn = 1;
    self.view.backgroundColor = [UIColor whiteColor];
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

-(void)refreshLoadMore
{
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    [self.dataSource removeAllObjects];
    pn = 1;
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *type = @"1";
    NSString *page = [NSString stringWithFormat:@"%d",pn];
    NSDictionary *para = @{@"uid":uid,@"token":token,@"page":page,@"type":type};
    [DNNetworking postWithURLString:post_bbsgetinfo parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *data = [obj objectForKey:@"data"];
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = [data objectAtIndex:i];
                bbsModel *model = [[bbsModel alloc] init];
                model.name = [dic objectForKey:@"name"];
                model.picture = [dic objectForKey:@"picture"];
                model.bbs_addtime = [dic objectForKey:@"bbs_addtime"];
                model.bbs_address = [dic objectForKey:@"bbs_address"];
                model.bbs_id = [dic objectForKey:@"bbs_id"];
                model.bbs_picture1 = [dic objectForKey:@"bbs_picture1"];
                model.bbs_picture2 = [dic objectForKey:@"bbs_picture2"];
                model.bbs_picture3 = [dic objectForKey:@"bbs_picture3"];
                model.bbs_thumbs = [dic objectForKey:@"bbs_thumbs"];
                model.bbs_title = [dic objectForKey:@"bbs_title"];
                model.bbs_userid = [dic objectForKey:@"bbs_userid"];
                model.is_point = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_point"]];
                [self.dataSource addObject:model];
            }
            
            [self.table reloadData];
        }
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        [self.table endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.table endHeaderRefresh];
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(void)footerRefreshEndAction
{
    pn ++;
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *type = @"1";
    NSString *page = [NSString stringWithFormat:@"%d",pn];
    
    NSDictionary *para = @{@"uid":uid,@"token":token,@"page":page,@"type":type};
    [DNNetworking postWithURLString:post_bbsgetinfo parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *data = [obj objectForKey:@"data"];
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = [data objectAtIndex:i];
                bbsModel *model = [[bbsModel alloc] init];
                model.name = [dic objectForKey:@"name"];
                model.picture = [dic objectForKey:@"picture"];
                model.bbs_addtime = [dic objectForKey:@"bbs_addtime"];
                model.bbs_address = [dic objectForKey:@"bbs_address"];
                model.bbs_id = [dic objectForKey:@"bbs_id"];
                model.bbs_picture1 = [dic objectForKey:@"bbs_picture1"];
                model.bbs_picture2 = [dic objectForKey:@"bbs_picture2"];
                model.bbs_picture3 = [dic objectForKey:@"bbs_picture3"];
                model.bbs_thumbs = [dic objectForKey:@"bbs_thumbs"];
                model.bbs_title = [dic objectForKey:@"bbs_title"];
                model.bbs_userid = [dic objectForKey:@"bbs_userid"];
                model.is_point = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_point"]];
                [self.dataSource addObject:model];
            }
            
            [self.table reloadData];
        }
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        [self.table endFooterRefresh];
    } failure:^(NSError *error) {
        [self.table endFooterRefresh];
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-50)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bbsCell *cell = [tableView dequeueReusableCellWithIdentifier:hotidentfid];
    cell = [[bbsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoTableViewController *vc = [[DemoTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)bbspointbtnClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.table indexPathForCell:cell];
    NSLog(@"index------%ld",(long)index.row);
    bbsModel *model = self.dataSource[index.row];
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *bbs_id = model.bbs_id;
    
    NSString *type = @"";
    
    if ([model.is_point isEqualToString:@"0"]) {
        type = @"1";
    }
    else
    {
        type = @"2";
    }
    
    NSDictionary *para = @{@"uid":uid,@"token":token,@"bbs_id":bbs_id,@"type":type};
    [DNNetworking postWithURLString:post_point parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            [self headerRefreshEndAction];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}
@end
