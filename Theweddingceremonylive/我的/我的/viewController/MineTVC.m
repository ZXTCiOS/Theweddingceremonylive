//
//  MineTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MineTVC.h"
#import "ModifyInfoVC.h"
#import "SystemMessageTVC.h"
#import "MyGiftTVC.h"
#import "MyWalletTVC.h"
#import "mineCell0.h"
#import "mineCell1.h"
#import "mineheadView.h"
#import "ModifyInfoVC.h"
#import "SaveCenterVC.h"
#import "MyShopTVC.h"
#import "mineOrderVC.h"

#import "LoginVC.h"

#import "CustomerserviceVC.h"
#import "aboutVC.h"

@interface MineTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) mineheadView *headView;
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) NSDictionary *dataDic;
@end
static NSString *mineidentfid0 = @"mineidentfid0";
static NSString *mineidentfid1 = @"mineidentfid1";
static NSString *mineidentfid2 = @"mineidentfid2";

@implementation MineTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self contentInit];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
    self.table.tableFooterView = [UIView new];
    [self loaddata];
}


-(void)loaddata
{
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defat objectForKey:user_uid];
    NSString *token = [defat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_getinfo parameters:para success:^(id obj) {
        NSLog(@"obj------%@",obj);
        if ([[obj objectForKey:@"code"] intValue]==1000) {
           self.dataDic =  [obj objectForKey:@"data"];
            self.headView.nameLab.text = [self.dataDic objectForKey:@"name"];
            self.headView.idLab.text = [self.dataDic objectForKey:@"uid"];
            [self.headView.userImg sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"picture"]]];
     
        }
        else
        {
            [MBProgressHUD showSuccess:@"失败"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"失败"];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-50)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(mineheadView *)headView
{
    if(!_headView)
    {
        _headView = [[mineheadView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreenW, 210*HEIGHT_SCALE);
        [_headView.btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
        [_headView.btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
        [_headView.btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headView;
}

-(NSDictionary *)dataDic
{
    if(!_dataDic)
    {
        _dataDic = [NSDictionary dictionary];

    }
    return _dataDic;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }
    if (section==1) {
        return 2;
    }
    if (section==2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        mineCell0 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid0];
        if (!cell) {
            cell = [[mineCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid0];
        }
        if (indexPath.row==0) {
            cell.leftImg.image = [UIImage imageNamed:@"my_walet"];
            cell.typeLab.text = @"我的钱包";
        }
        if (indexPath.row==1) {
            cell.leftImg.image = [UIImage imageNamed:@"my_gift"];
            cell.typeLab.text = @"我的礼物";
        }
        if (indexPath.row==2) {
            cell.leftImg.image = [UIImage imageNamed:@"my_xt"];
            cell.typeLab.text = @"我的喜帖";
        }
        if (indexPath.row==3) {
            cell.leftImg.image = [UIImage imageNamed:@"my_business"];
            cell.typeLab.text = @"关注商家";
        }
        if (indexPath.row==4) {
            cell.leftImg.image = [UIImage imageNamed:@"my_oder"];
            cell.typeLab.text = @"我的订单";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        mineCell0 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid1];
        if (!cell) {
            cell = [[mineCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid1];
        }
        if (indexPath.row==0) {
            cell.leftImg.image = [UIImage imageNamed:@"my_help"];
            cell.typeLab.text = @"客服帮助";
        }
        if (indexPath.row==1) {
            cell.leftImg.image = [UIImage imageNamed:@"my_about"];
            cell.typeLab.text = @"关于";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid2];
        if (!cell) {
            cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid2];
        }
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"E95F46"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

#pragma mark - UITableViewDelegate

- (IBAction)systemMessage:(id)sender {
    SystemMessageTVC *vc = [[SystemMessageTVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)modifyInfo:(id)sender {
    ModifyInfoVC *vc = [[ModifyInfoVC alloc] initWithNibName:@"ModifyInfoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)safeCenter:(id)sender {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:// 钱包
            {
                MyWalletTVC *wallet = [[MyWalletTVC alloc] init];
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 1:// 礼物
            {
                MyGiftTVC *vc = [[MyGiftTVC alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:// 喜帖
            {
                
            }
                break;
            case 3:// 商家
            {
                MyShopTVC *vc = [[MyShopTVC alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:// 订单
            {
                mineOrderVC *vc = [[mineOrderVC alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }

    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            // 客服帮助
            CustomerserviceVC *vc = [[CustomerserviceVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            // 关于我们
            aboutVC *vc = [[aboutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==2) {
        NSLog(@"退出登录");
        
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"缺点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:user_token];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:user_uid];
            [[NSUserDefaults standardUserDefaults] synchronize];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UINavigationController *navcon = [[UINavigationController alloc] init];
            LoginVC *vc = [[LoginVC alloc] init];
            navcon.viewControllers = @[vc];
            appDelegate.window.rootViewController = navcon;
            
        }];
        
        [control addAction:action0];
        [control addAction:action1];
        [self presentViewController:control animated:YES completion:nil];
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现方法

-(void)btn0click
{
    SystemMessageTVC *sysvc = [[SystemMessageTVC alloc] init];
    [self.navigationController pushViewController:sysvc animated:YES];
}

-(void)btn1click
{
    ModifyInfoVC *modvc = [[ModifyInfoVC alloc] init];
    [self.navigationController pushViewController:modvc animated:YES];
}

-(void)btn2click
{
    SaveCenterVC *safevc = [[SaveCenterVC alloc] init];
    [self.navigationController pushViewController:safevc animated:YES];
}
@end
