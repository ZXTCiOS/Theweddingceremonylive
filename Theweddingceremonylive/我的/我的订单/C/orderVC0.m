//
//  orderVC0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderVC0.h"
#import "orderCell.h"

@interface orderVC0 ()<UITableViewDataSource,UITableViewDelegate,mysubmitVdelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *orderidentfid0 = @"orderidentfid0";

@implementation orderVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderidentfid0];
    cell = [[orderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderidentfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*HEIGHT_SCALE;
}

-(void)submitbtnClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.table indexPathForCell:cell];
    NSLog(@"index------%ld",(long)index.row);
}

@end
