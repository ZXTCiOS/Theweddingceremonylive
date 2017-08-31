//
//  aboutVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutVC.h"
#import "feedbackVC.h"
#import "userprotocolVC.h"
#import "guanyuusVC.h"

@interface aboutVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *aboutidentfid = @"aboutidentfid";

@implementation aboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    if (indexPath.row==0) {
        cell.textLabel.text = @"检测更新";
    }
    if (indexPath.row==1) {
        cell.textLabel.text = @"意见反馈";
        
    }
    if (indexPath.row==2) {
        cell.textLabel.text = @"用户协议";
    }
    if (indexPath.row==3) {
        cell.textLabel.text = @"关于我们";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
    }
    if (indexPath.row==1) {
        feedbackVC *vc = [[feedbackVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        userprotocolVC *vc = [[userprotocolVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
        guanyuusVC *vc = [[guanyuusVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
