//
//  orderchanpingVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "orderchanpingVC.h"
#import "weddingCell.h"
#import "DLAlertView.h"
#import "orderPayVC.h"
#import "weddinglistModel.h"

@interface orderchanpingVC ()<UITableViewDataSource,UITableViewDelegate,myweddingVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource0;
@property (nonatomic,strong) NSMutableArray *datasource1;

@property (nonatomic,strong) NSString *order_goodsstr;
@property (nonatomic,strong) NSString *order_goods_tuijian;

@property (nonatomic,strong) NSString *zhencangname;
@property (nonatomic,strong) NSString *zhencangprice;

@property (nonatomic,strong) NSString *tuijianname;
@property (nonatomic,strong) NSString *tuijianprice;

@property (nonatomic,strong) NSString *price0;
@property (nonatomic,strong) NSString *price1;

@end
static NSString *orderchanpingidengfid = @"orderchanpingidengfid";
@implementation orderchanpingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.view addSubview:self.table];
    self.datasource0 = [NSMutableArray array];
    self.datasource1 = [NSMutableArray array];
    [self loaddata];
    if ([self.typestr isEqualToString:@"1"]) {
        self.order_pattern = @"1";
        self.room_count = @"100";
        self.create_time = @"";
    }

    // Do any additional setup after loading the view.
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-60) style:UITableViewStyleGrouped];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40*HEIGHT_SCALE)];
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(14*WIDTH_SCALE, 0, 100, 40*HEIGHT_SCALE)];
    namelab.textColor = [UIColor colorWithHexString:@"333333"];
    namelab.font = [UIFont systemFontOfSize:15];
    if (section==0) {
        namelab.text = @"一生珍藏";
    }
    if (section==1) {
        namelab.text = @"推荐之选";
    }
    [view addSubview:namelab];
    return view;
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
    weddingCell *cell = [tableView dequeueReusableCellWithIdentifier:orderchanpingidengfid];
    cell = [[weddingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderchanpingidengfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        
        [cell setdata:self.datasource0[indexPath.row]];
    }
    if (indexPath.section==1) {
        
        [cell setdata:self.datasource1[indexPath.row]];
        
    }
    cell.delegate = self;
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

-(void)choosebtnClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.table indexPathForCell:cell];
    NSLog(@"index------%ld",(long)index.row);
    if (index.section==0) {
        
        
        if (index.row==0) {
            weddinglistModel *model0 = [self.datasource0 objectAtIndex:0];
            weddinglistModel *model1 = [self.datasource0 objectAtIndex:1];
            weddinglistModel *model2 = [self.datasource0 objectAtIndex:2];
            model0.ischoose = YES;
            model1.ischoose = NO;
            model2.ischoose = NO;
            self.order_goodsstr = model0.idstr;
            self.zhencangname = model0.name;
            self.zhencangprice = model0.money;
            
            self.price0 = model0.money;
        }
        if (index.row==1) {
            weddinglistModel *model0 = [self.datasource0 objectAtIndex:0];
            weddinglistModel *model1 = [self.datasource0 objectAtIndex:1];
            weddinglistModel *model2 = [self.datasource0 objectAtIndex:2];
            model0.ischoose = NO;
            model1.ischoose = YES;
            model2.ischoose = NO;
            self.order_goodsstr = model1.idstr;
            self.zhencangname = model1.name;
            self.zhencangprice = model1.money;
            
            self.price0 = model1.money;
        }
        if (index.row==2) {
            weddinglistModel *model0 = [self.datasource0 objectAtIndex:0];
            weddinglistModel *model1 = [self.datasource0 objectAtIndex:1];
            weddinglistModel *model2 = [self.datasource0 objectAtIndex:2];
            model0.ischoose = NO;
            model1.ischoose = NO;
            model2.ischoose = YES;
            self.order_goodsstr = model2.idstr;
            self.zhencangname = model2.name;
            self.zhencangprice = model2.money;
            
            self.price0 = model2.money;
        }
        
        [self.table reloadData];
    }
    if (index.section==1) {
        weddinglistModel *model = self.datasource1[index.row];
        model.ischoose = !model.ischoose;
        [self.table reloadData];
        
        
        NSMutableArray *selecarr = [NSMutableArray array];
        NSMutableArray *namearr = [NSMutableArray array];
        NSMutableArray *moneyarr = [NSMutableArray array];
        
        
        for (int i=0; i<self.datasource1.count; i++) {
            weddinglistModel *model2 = self.datasource1[i];;
            NSString *str = [NSString stringWithFormat:@"%d",model2.ischoose];
            [selecarr addObject:str];
        }
        if ([selecarr containsObject:@"1"])
        {
            NSMutableArray *pidarr = [NSMutableArray array];
            for (int t=0; t<self.datasource1.count; t++) {
                if ([selecarr[t] isEqualToString:@"1"]) {
                    weddinglistModel *model3 = [self.datasource1 objectAtIndex:t];
                    [pidarr addObject:model3.idstr];
                    [namearr addObject:model3.name];
                    [moneyarr addObject:model3.money];
                }
            }
            NSString *idstrnum = [pidarr componentsJoinedByString:@","];
            NSLog(@"numberstr ------- %@",idstrnum);
            self.tuijianname = [namearr componentsJoinedByString:@","];
            self.tuijianprice = [moneyarr componentsJoinedByString:@","];
            self.order_goods_tuijian = idstrnum;
            NSNumber *sum = [moneyarr valueForKeyPath:@"@sum.floatValue"];
            self.price1 = [NSString stringWithFormat:@"%@",sum];
            
        }
    }
}

-(void)rightAction
{
    
    orderPayVC *vc = [[orderPayVC alloc] init];
    if ([self.typestr isEqualToString:@"1"]) {
        vc.name0 = self.typenamestr;
    }
    else
    {
        vc.name0 = [NSString stringWithFormat:@"%@%@%@",self.typenamestr,@" ",self.pricestr];
    }
    vc.ordersn = self.ordersn;
    vc.name1 = [NSString stringWithFormat:@"%@%@%@",self.zhencangname,@" ",self.zhencangprice];
    vc.name2 = [NSString stringWithFormat:@"%@%@%@",self.tuijianname,@" ",self.tuijianprice];
    
    if ([strisNull isNullToString:self.order_goodsstr]) {
        [MBProgressHUD showSuccess:@"请选择商品"];
    }
    else
    {
        vc.order_goods = self.order_goodsstr;
        vc.order_goods_tuijian = self.order_goods_tuijian;
        NSInteger price = [self.price0 floatValue]+[self.price1 floatValue]+[self.pricestr floatValue];
        vc.order_price = [NSString stringWithFormat:@"%.2ld",(long)price];
        vc.room_count = self.room_count;
        vc.order_pattern = self.order_pattern;
        vc.create_time = self.create_time;
        vc.tuijian = self.tuijian;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
