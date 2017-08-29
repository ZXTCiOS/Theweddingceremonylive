//
//  walletrecordVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/29.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "walletrecordVC.h"
#import "walletrecordCell.h"

@interface walletrecordVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *walletrcordientfid = @"walletrcordientfid";

@implementation walletrecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"财富记录";
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

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    walletrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:walletrcordientfid];
    cell = [[walletrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletrcordientfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (36+14+14)*HEIGHT_SCALE;
}

@end
