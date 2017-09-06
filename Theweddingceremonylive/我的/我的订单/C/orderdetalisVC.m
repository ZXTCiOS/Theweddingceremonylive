//
//  orderdetalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderdetalisVC.h"

@interface orderdetalisVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;

@end

@implementation orderdetalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    
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
//    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
//    NSString *uid = [userdefat objectForKey:user_uid];
//    NSString *token = [userdefat objectForKey:user_token];
//    
}

#pragma mark - getters


-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
}

@end
