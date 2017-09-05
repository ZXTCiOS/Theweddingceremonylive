//
//  orderVC0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderVC0.h"
#import "orderCell.h"
#import "orderModel.h"

@interface orderVC0 ()<UITableViewDataSource,UITableViewDelegate,mysubmitVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *orderidentfid0 = @"orderidentfid0";

@implementation orderVC0

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
    NSString *type = @"1";
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
    orderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderidentfid0];
    cell = [[orderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderidentfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setdata:self.dataSource[indexPath.row]];
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
