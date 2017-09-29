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
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                walletlistModel *model = [[walletlistModel alloc] init];
                NSDictionary *dic = [dataarr objectAtIndex:i];
                model.zhuangtai = [dic objectForKey:@"zhuangtai"];
                model.createtime = [dic objectForKey:@"createtime"];
                model.goin_id = [dic objectForKey:@"goin_id"];
                model.goin_moeny = [dic objectForKey:@"goin_moeny"];
                model.goin_userid = [dic objectForKey:@"goin_userid"];
                model.yue = [dic objectForKey:@"yue"];
                
                model.bankid = [dic objectForKey:@"bankid"];
                model.idstr = [dic objectForKey:@"id"];
                model.id_card = [dic objectForKey:@"id_card"];
                model.is_give = [dic objectForKey:@"is_give"];
                model.money = [dic objectForKey:@"money"];
                model.name = [dic objectForKey:@"name"];
                model.type = [dic objectForKey:@"tyoe"];
                model.userid = [dic objectForKey:@"userid"];
                
                model.giftinfo_giftid = [dic objectForKey:@"giftinfo_giftid"];
                model.giftinfo_id = [dic objectForKey:@"giftinfo_id"];
                model.giftinfo_price = [dic objectForKey:@"giftinfo_price"];
                model.giftinfo_userid = [dic objectForKey:@"giftinfo_userid"];
                model.giftinfo_yue = [dic objectForKey:@"giftinfo_yue"];
                
                [self.dataSource addObject:model];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    walletrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:walletrcordientfid0];
    cell = [[walletrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletrcordientfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata0:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (36+14+14)*HEIGHT_SCALE;
}

@end
