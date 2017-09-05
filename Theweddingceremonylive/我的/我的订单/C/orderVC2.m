//
//  orderVC2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderVC2.h"
#import "orderCell2.h"
#import "orderModel.h"

@interface orderVC2 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

static NSString *orderidentfid3 = @"orderidentfid3";

@implementation orderVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSString *type = @"3";
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
    orderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:orderidentfid3];
    cell = [[orderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderidentfid3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE;
}


@end
