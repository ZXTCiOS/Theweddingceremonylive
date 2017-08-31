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
#import "weddinglistModel.h"

@interface weddingproductsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource0;
@property (nonatomic,strong) NSMutableArray *datasource1;
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
    self.datasource0 = [NSMutableArray array];
    self.datasource1 = [NSMutableArray array];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    [self.datasource0 removeAllObjects];
    [self.datasource1 removeAllObjects];
    NSUserDefaults *detat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [detat objectForKey:user_uid];
    NSString *token = [detat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_goodslist parameters:para success:^(id obj) {
        
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *datadic = [obj objectForKey:@"data"];
            NSArray *moren = [datadic objectForKey:@"moren"];
            
            for (int i = 0; i<moren.count; i++) {
                NSDictionary *dic = [moren objectAtIndex:i];
                weddinglistModel *model = [[weddinglistModel alloc] init];
                model.goods_info_img = [dic objectForKey:@"goods_info_img"];
                model.goods_jianjie = [dic objectForKey:@"goods_jianjie"];
                model.goods_list_img = [dic objectForKey:@"goods_list_img"];
                model.idstr = [dic objectForKey:@"id"];
                model.info = [dic objectForKey:@"info"];
                model.money = [dic objectForKey:@"money"];
                model.name = [dic objectForKey:@"name"];
                model.type = [dic objectForKey:@"type"];
                [self.datasource0 addObject:model];
            }
            
            NSArray *tuijian = [datadic objectForKey:@"tuijian"];
            for (int i = 0; i<tuijian.count; i++) {
                NSDictionary *dic = [tuijian objectAtIndex:i];
                weddinglistModel *model = [[weddinglistModel alloc] init];
                model.goods_info_img = [dic objectForKey:@"goods_info_img"];
                model.goods_jianjie = [dic objectForKey:@"goods_jianjie"];
                model.goods_list_img = [dic objectForKey:@"goods_list_img"];
                model.idstr = [dic objectForKey:@"id"];
                model.info = [dic objectForKey:@"info"];
                model.money = [dic objectForKey:@"money"];
                model.name = [dic objectForKey:@"name"];
                model.type = [dic objectForKey:@"type"];
                [self.datasource1 addObject:model];
            }
            
            [self.table reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
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
        return self.datasource0.count;
    }
    if (section==1) {
        return self.datasource1.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    weddingCell *cell = [tableView dequeueReusableCellWithIdentifier:weddingidentfid];
    cell = [[weddingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weddingidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {

        [cell setdata:self.datasource0[indexPath.row]];
    }
    if (indexPath.section==1) {

        [cell setdata:self.datasource1[indexPath.row]];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        weddinglistModel *model = self.datasource0[indexPath.row];
        NSString *imgstr = model.goods_list_img;
        NSString *infostr = model.info;
        
        DLAlertView *alert = [[DLAlertView alloc] initWithWithImage:imgstr initWithWithContent:infostr clickCallBack:^{
            
        } andCloseCallBack:^{
            
        }];
        [alert show];
        
    }
    if (indexPath.section==1) {
        weddinglistModel *model = self.datasource1[indexPath.row];
        NSString *imgstr = model.goods_list_img;
        NSString *infostr = model.info;
        
        DLAlertView *alert = [[DLAlertView alloc] initWithWithImage:imgstr initWithWithContent:infostr clickCallBack:^{
            
        } andCloseCallBack:^{
            
        }];
        [alert show];
    }
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
