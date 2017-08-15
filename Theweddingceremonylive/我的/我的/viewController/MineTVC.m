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

@interface MineTVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *nameLab;

@end
static NSString *mineidentfid0 = @"mineidentfid0";
static NSString *mineidentfid1 = @"mineidentfid1";
static NSString *mineidentfid2 = @"mineidentfid2";

@implementation MineTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self contentInit];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.table];
//    [self.view addSubview:self.headView];
//    self.table.tableFooterView = [UIView new];
//    
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
        
        return cell;
    }
    if (indexPath.section==1) {
        
    }
    if (indexPath.section==2) {
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
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
    if (!indexPath.section) {
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
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:// 喜帖
            {
                
            }
                break;
            case 3:// 商家
            {
                
            }
                break;
            default:
                break;
        }
    } else {
        if (indexPath.row) {
            // 客服帮助
            
        } else {
            // 关于我们
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
