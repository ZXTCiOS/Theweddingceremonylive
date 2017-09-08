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
#import "orderdetalisCell3.h"
#import "wanshanorderVC.h"

@interface orderdetalisVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,assign) BOOL istuijianxuanze;

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
    
    self.istuijianxuanze = NO;
    
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
            
            id goods_tuijian = [self.dataDic objectForKey:@"goods_tuijian"];
            if ([goods_tuijian isKindOfClass:[NSArray class]]) {
                self.istuijianxuanze = YES;
            }
            else
            {
                self.istuijianxuanze = NO;
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
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.istuijianxuanze) {
        return 4;
    }
    else
    {
        return 3;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.istuijianxuanze) {
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
        if (indexPath.row==2) {
            orderdetalisCell3 *cell = [tableView dequeueReusableCellWithIdentifier:orderdetalisidentfid2];
            cell = [[orderdetalisCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderdetalisidentfid2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setData:self.dataDic];
            return cell;
        }
        if (indexPath.row==3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderdetalisidentfid3];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderdetalisidentfid3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"我的房间";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.textColor = [UIColor colorWithHexString:@"ed5e40 "];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            return cell;
        }

    }
    else
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
        if (indexPath.row==2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderdetalisidentfid3];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderdetalisidentfid3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"我的房间";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.textColor = [UIColor colorWithHexString:@"ed5e40 "];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            return cell;
        }
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.istuijianxuanze) {
        if (indexPath.row==0) {
            return 40*HEIGHT_SCALE;
        }
        if (indexPath.row==1) {
            return 40*HEIGHT_SCALE;
        }
        if (indexPath.row==2) {
            return [tableView cellHeightForIndexPath:indexPath
                                cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                           tableView:tableView];
            
        }
        if (indexPath.row==3) {
            return 40*HEIGHT_SCALE;
        }

    }
    else
    {
        if (indexPath.row==0) {
            return 40*HEIGHT_SCALE;
        }
        if (indexPath.row==1) {
            return 40*HEIGHT_SCALE;
        }
        if (indexPath.row==2) {
            return 40*HEIGHT_SCALE;
            
        }

    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.istuijianxuanze) {
        if (indexPath.row==3) {
            wanshanorderVC *vc = [[wanshanorderVC alloc] init];
            vc.orderdic = [NSDictionary dictionary];
            vc.orderdic = self.dataDic;
            vc.typestr = [self.dataDic objectForKey:@"pattern"];
            vc.yaoqingma = [NSString stringWithFormat:@"%@%@",@"邀请码 ",[self.dataDic objectForKey:@"password"]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        if (indexPath.row==2) {
            wanshanorderVC *vc = [[wanshanorderVC alloc] init];
            vc.orderdic = [NSDictionary dictionary];
            vc.orderdic = self.dataDic;
            vc.typestr = [self.dataDic objectForKey:@"pattern"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark - tabbar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
@end
