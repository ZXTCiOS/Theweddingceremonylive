//
//  SystemMessageTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "SystemMessageTVC.h"
#import "systemCell.h"
#import "systemModel.h"

@interface SystemMessageTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *systemcellidentfid = @"systencellidentfid";

@implementation SystemMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统消息";
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    
    [self loaddata];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    
}

- (void)rebackToRootViewAction {
    if ([self.typestr isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defat objectForKey:user_uid];
    NSString *token = [defat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_tuisongfankui parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                systemModel *model = [[systemModel alloc] init];
                model.push_addtime = [dic objectForKey:@"push_addtime"];
                model.push_title = [dic objectForKey:@"push_title"];
                model.push_content = [dic objectForKey:@"push_content"];
                model.push_id = [dic objectForKey:@"push_id"];
                [self.dataSource addObject:model];
                
                [self.table reloadData];
            }
        }
    } failure:^(NSError *error) {
        
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    systemCell *cell = [tableView dequeueReusableCellWithIdentifier:systemcellidentfid];
    cell = [[systemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systemcellidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
    
}

@end
