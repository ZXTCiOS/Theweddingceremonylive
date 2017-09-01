//
//  midVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "midVC.h"
#import "livetypeCell.h"
#import "predeterminedVC0.h"
#import "predeterminedVC1.h"

#import "RealVC.h"

#import "CustomerserviceVC.h"

@interface midVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *livecellidentfid = @"livecellidentfid";

@implementation midVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"类型";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    
//    [self realpush];
}

-(void)realpush
{
    RealVC *vc = [[RealVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    livetypeCell *cell = [tableView dequeueReusableCellWithIdentifier:livecellidentfid];
    if (!cell) {
        cell = [[livetypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:livecellidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.bgimg sd_setImageWithURL:[NSURL URLWithString:@"http://pic.pptbz.com/pptpic/201605/2016050149342801.jpg"]];
    if (indexPath.row==0) {
        cell.typelab.text = @"免费亲友内部直播";
        cell.numberlab.text = @"可观看人数：100人";
        [cell.pricelab setHidden:YES];
    }
    if (indexPath.row==1) {
        cell.typelab.text = @"旗舰款";
        cell.numberlab.text = @"可观看人数：500-1500人";
        cell.pricelab.text = @"520元起";
    }
    if (indexPath.row==2) {
        cell.typelab.text = @"公众人物直播";
        cell.numberlab.text = @"可观看人数：5000-15000人";
        cell.pricelab.text = @"2999元起";
    }
    if (indexPath.row==3) {
        cell.typelab.text = @"开放直播间";
        cell.numberlab.text = @"请联系客服";
        [cell.pricelab setHidden:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        predeterminedVC0 *vc = [[predeterminedVC0 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        predeterminedVC0 *vc = [[predeterminedVC0 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        predeterminedVC1 *vc = [[predeterminedVC1 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
       // [MBProgressHUD showSuccess:@"请联系客服"];
        CustomerserviceVC *vc = [[CustomerserviceVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220*HEIGHT_SCALE;
}
#pragma mark - 实现方法

-(void)backAction
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

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
