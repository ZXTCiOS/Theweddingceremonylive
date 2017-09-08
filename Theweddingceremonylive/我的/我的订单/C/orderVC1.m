//
//  orderVC1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderVC1.h"
#import "orderCell2.h"
#import "orderModel.h"
#import "orderdetalisVC.h"

@interface orderVC1 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *orderidentfid2 = @"orderidentfid2";

@implementation orderVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSString *type = @"2";
    NSDictionary *para = @{@"uid":uid,@"token":token,@"type":type};
    [DNNetworking postWithURLString:post_ordering parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                orderModel *model = [[orderModel alloc] init];
                model.create_time = [dic objectForKey:@"create_time"];
                model.ordernb = [dic objectForKey:@"ordernb"];
                model.ordertime = [dic objectForKey:@"ordertime"];
                model.room_img = [dic objectForKey:@"room_img"];
                model.room_name = [dic objectForKey:@"room_name"];
                
                [self.dataSource addObject:model];
            }
            
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-120*HEIGHT_SCALE)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:orderidentfid2];
    cell = [[orderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderidentfid2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderdetalisVC *vc = [[orderdetalisVC alloc] init];
    orderModel *model = self.dataSource[indexPath.row];
    vc.ordersn = model.ordernb;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
