//
//  detalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisVC.h"
#import "detalisCell0.h"
#import "detalisCell1.h"
#import "detalisModel.h"

@interface detalisVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *headdic;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *detalisidentfid0 = @"detalisidentfid0";
static NSString *detalisidentfid1 = @"detalisidentfid1";

@implementation detalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    self.headdic = [NSDictionary dictionary];
    self.dataSource = [NSMutableArray array];
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
    [self.dataSource removeAllObjects];
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defat objectForKey:user_uid];
    NSString *token = [defat objectForKey:user_token];
    self.bbs_id = @"22";
    NSDictionary *para = @{@"uid":uid,@"token":token,@"bbs_id":self.bbs_id};
    [DNNetworking postWithURLString:post_getallinfo parameters:para success:^(id obj) {
        NSLog(@"obj-----%@",obj);
        NSString *msg = [obj objectForKey:@"msg"];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *datadic = [obj objectForKey:@"data"];
            self.headdic = [NSDictionary dictionary];
            self.headdic = [datadic objectForKey:@"bbsinfo"];
            
            NSArray *huifu = [datadic objectForKey:@"huifu"];
            for (int i = 0; i<huifu.count; i++) {
                NSDictionary *dic = [huifu objectAtIndex:i];
                detalisModel *model = [[detalisModel alloc] init];
                model.bbs_content = [dic objectForKey:@"bbs_content"];

                model.bbs_content_addtime = [dic objectForKey:@"bbs_content_addtime"];
                model.bbs_content_bbs_id = [dic objectForKey:@"bbs_content_bbs_id"];
                model.bbs_content_id = [dic objectForKey:@"bbs_content_id"];
                model.bbs_content_send_uid = [dic objectForKey:@"bbs_content_send_uid"];
                model.bbs_content_to_name = [dic objectForKey:@"bbs_content_to_name"];
                model.bbs_content_to_uid = [dic objectForKey:@"bbs_content_to_uid"];
                model.bbs_content_type = [dic objectForKey:@"bbs_content_type"];
                NSDictionary *user1info = [NSDictionary dictionary];
                NSDictionary *user2info = [NSDictionary dictionary];
                user1info = [dic objectForKey:@"user1info"];
                user2info = [dic objectForKey:@"user2info"];
                
                model.user1infouid = [user1info objectForKey:@"uid"];
                model.user1infoname = [user1info objectForKey:@"name"];
                
                model.user2infouid = [user2info objectForKey:@"uid"];
                model.user2infoname = [user2info objectForKey:@"name"];
                [self.dataSource addObject:model];
            }
            
        }
        [MBProgressHUD showSuccess:msg];
        [self.table reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        detalisCell0 *cell = [tableView dequeueReusableCellWithIdentifier:detalisidentfid0];
        cell = [[detalisCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalisidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.headdic];
        return cell;
    }
    if (indexPath.section==1) {
        detalisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:detalisidentfid1];
        cell = [[detalisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalisidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.dataSource[indexPath.row]];
        return cell;
    }
    return nil;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
