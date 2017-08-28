//
//  weddingproductsVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingproductsVC.h"
#import "weddingCell.h"
#import "DLAlertView.h"
#import "weddingPayVC.h"

@interface weddingproductsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;

@end

static NSString *weddingidentfid = @"weddingidentfid";

@implementation weddingproductsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"婚礼产品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getteres

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    weddingCell *cell = [tableView dequeueReusableCellWithIdentifier:weddingidentfid];
    cell = [[weddingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weddingidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.typelab.text = @"高清版";
            cell.contentlab.text = @"未剪辑，网盘下载";
            cell.pricelab.text = @"¥59";
        }
        if (indexPath.row==1) {
            cell.typelab.text = @"高清 无弹幕 无水印";
            cell.contentlab.text = @"未剪辑，网盘下载，多个版本";
            cell.pricelab.text = @"¥99";
        }
        if (indexPath.row==2) {
            cell.typelab.text = @"礼盒装";
            cell.contentlab.text = @"剪辑版，快递发货";
            cell.pricelab.text = @"¥520";
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.typelab.text = @"礼盒装";
            cell.contentlab.text = @"剪辑版，快递发货";
            cell.pricelab.text = @"¥520";
        }
        if (indexPath.row==1) {
            cell.typelab.text = @"礼盒装";
            cell.contentlab.text = @"剪辑版，快递发货";
            cell.pricelab.text = @"¥520";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLAlertView *alert = [[DLAlertView alloc] initWithWithImage:@"http://img1.gtimg.com/ent/pics/hv1/213/155/1650/107330988.jpg" initWithWithContent:@"定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型定义一个字符串a， 截取a 的某一个项目组，复制给b， b必须是int型" clickCallBack:^{
        
    } andCloseCallBack:^{
        
    }];
    [alert show];
}

-(void)rightAction
{
    weddingPayVC *vc = [[weddingPayVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
