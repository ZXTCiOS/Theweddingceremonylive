//
//  orderdetalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderdetalisVC.h"
#import "orderdetalisCell.h"
#import "orderdetalisCell2.h"

@interface orderdetalisVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

static NSString *orderdetalisidentfid0 = @"orderdetalisidentfid0";
static NSString *orderdetalisidentfid1 = @"orderdetalisidentfid1";
static NSString *orderdetalisidentfid2 = @"orderdetalisidentfid2";
static NSString *orderdetalisidentfid3 = @"orderdetalisidentfid3";

@implementation orderdetalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.dataDic = [NSDictionary dictionary];
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
    NSDictionary *para = @{@"uid":uid,@"token":token,@"ordersn":self.ordersn};
    [DNNetworking postWithURLString:post_orderdetalis parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            self.dataDic = [obj objectForKey:@"data"];
            
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        orderdetalisCell *cell = [tableView dequeueReusableCellWithIdentifier:orderdetalisidentfid0];
        cell = [[orderdetalisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderdetalisidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:self.dataDic];
        return cell;
    }
    if (indexPath.row==1) {
        orderdetalisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:orderdetalisidentfid1];
        cell = [[orderdetalisCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderdetalisidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:self.dataDic];
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*HEIGHT_SCALE;
}

@end
