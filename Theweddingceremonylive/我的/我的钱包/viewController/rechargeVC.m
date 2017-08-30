//
//  rechargeVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rechargeVC.h"
#import "rechargrCell0.h"
//#import "footView.h"

@interface rechargeVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
//@property (nonatomic,strong) footView *fview;
@end

static NSString *rechargeidentfid0 = @"rechargeidentfid0";

@implementation rechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值";
    
    [self.view addSubview:self.table];
//    self.table.tableFooterView = self.fview;
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}
//
//-(footView *)fview
//{
//    if(!_fview)
//    {
//        _fview = [[footView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 500)];
//        _fview.backgroundColor = [UIColor whiteColor];
//        _fview.moneytext.delegate = self;
//    }
//    return _fview;
//}
//
#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rechargrCell0 *cell = [tableView dequeueReusableCellWithIdentifier:rechargeidentfid0];
    cell = [[rechargrCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rechargeidentfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

#pragma mark - 实现方法

@end
