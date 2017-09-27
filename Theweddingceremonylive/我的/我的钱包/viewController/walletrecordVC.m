//
//  walletrecordVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/29.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "walletrecordVC.h"
#import "walletrecordCell.h"
#import "walletlistModel.h"

@interface walletrecordVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *tixianarray;
@property (nonatomic,strong) NSMutableArray *liwuarray;
@property (nonatomic,strong) NSMutableArray *chongzhiarray;
@end

static NSString *walletrcordientfid0 = @"walletrcordientfid0";
static NSString *walletrcordientfid1 = @"walletrcordientfid1";
static NSString *walletrcordientfid2 = @"walletrcordientfid2";

@implementation walletrecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"财富记录";
    self.dataSource = [NSMutableArray array];
    self.tixianarray = [NSMutableArray array];
    self.liwuarray = [NSMutableArray array];
    self.chongzhiarray = [NSMutableArray array];
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    [self loaddata];
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    NSCalendar *calendar = nil;
    if (version.doubleValue >= 11.0) { // iOS系统版本 >= 11.0
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        //这里适配iOS11
        if (@available(iOS 11.0, *)) {
            self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        self.table.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.table.scrollIndicatorInsets = self.table.contentInset;
    } else{ //iOS系统版本 < 11.0
        calendar = [NSCalendar currentCalendar];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_moenylist parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NSArray *arr0 = [data objectForKey:@"chongzhi"];
            NSArray *arr1 = [data objectForKey:@"liwu"];
            NSArray *arr2 = [data objectForKey:@"tixian"];
            for (int i = 0; i<arr0.count; i++) {
                NSDictionary *dic = [arr0 objectAtIndex:i];
                walletlistModel *model = [[walletlistModel alloc] init];
                model.createtime = [dic objectForKey:@"createtime"];
                model.goin_id = [dic objectForKey:@"goin_id"];
                model.goin_moeny = [dic objectForKey:@"goin_moeny"];
                model.goin_userid = [dic objectForKey:@"goin_userid"];
                model.yue = [dic objectForKey:@"yue"];
                [self.chongzhiarray addObject:model];
            }
            for (int i = 0; i<arr1.count; i++) {
                NSDictionary *dic = [arr1 objectAtIndex:i];
                walletlistModel *model = [[walletlistModel alloc] init];
                model.giftinfo_addtime = [dic objectForKey:@"giftinfo_addtime"];
                model.giftinfo_giftid = [dic objectForKey:@"giftinfo_giftid"];
                model.giftinfo_id = [dic objectForKey:@"giftinfo_id"];
                model.giftinfo_userid = [dic objectForKey:@"giftinfo_userid"];
                model.giftinfo_yue = [dic objectForKey:@"giftinfo_yue"];
                model.giftinfo_price = [dic objectForKey:@"giftinfo_price"];
                [self.liwuarray addObject:model];
            }
            for (int i = 0; i<arr2.count; i++) {
                NSDictionary *dic = [arr2 objectAtIndex:i];
                walletlistModel *model = [[walletlistModel alloc] init];
                model.bankid = [dic objectForKey:@"bankid"];
                model.createtime = [dic objectForKey:@"createtime"];
                model.idstr = [dic objectForKey:@"id"];
                model.id_card = [dic objectForKey:@"id_card"];
                model.is_give = [dic objectForKey:@"is_give"];
                model.money = [dic objectForKey:@"money"];
                model.name = [dic objectForKey:@"name"];
                model.type = [dic objectForKey:@"type"];
                model.userid = [dic objectForKey:@"userid"];
                
                [self.tixianarray addObject:model];
            }
            [self.table reloadData];
        }
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
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

#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.chongzhiarray.count;
    }
    if (section==1) {
        return self.liwuarray.count;
    }
    if (section==2) {
        return self.tixianarray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        walletrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:walletrcordientfid0];
        cell = [[walletrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletrcordientfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata0:self.chongzhiarray[indexPath.row]];
        return cell;
    }
    if (indexPath.section==1) {
        walletrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:walletrcordientfid1];
        cell = [[walletrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletrcordientfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata1:self.liwuarray[indexPath.row]];
        return cell;
    }
    if (indexPath.section==2) {
        walletrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:walletrcordientfid2];
        cell = [[walletrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletrcordientfid2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata2:self.tixianarray[indexPath.row]];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (36+14+14)*HEIGHT_SCALE;
}

@end
