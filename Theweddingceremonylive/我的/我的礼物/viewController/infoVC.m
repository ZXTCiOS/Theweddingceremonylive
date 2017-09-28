//
//  infoVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoVC.h"
#import "infoCell0.h"
#import "infoCell1.h"
#import "infoCell2.h"
#import "infoCell3.h"

@interface infoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UILabel *footlab;
@property (nonatomic,strong) UIView *footview;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

static NSString *infocellidentfid0 = @"infoidentfid0";
static NSString *infocellidentfid1 = @"infoidentfid1";
static NSString *infocellidentfid2 = @"infoidentfid2";
static NSString *infocellidentfid3 = @"infoidentfid3";
static NSString *infocellidentfid4 = @"infoidentfid4";
static NSString *infocellidentfid5 = @"infoidentfid5";
static NSString *infocellidentfid6 = @"infoidentfid6";

@implementation infoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.dataDic = [NSDictionary dictionary];
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footview;
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
    
    NSDictionary *para = @{@"uid":uid,@"useruid":self.useruid,@"token":token};
    [DNNetworking postWithURLString:post_finduserinfo parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            self.dataDic = [obj objectForKey:@"data"];
        }
        [self.table reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
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

-(UILabel *)footlab
{
    if(!_footlab)
    {
        _footlab = [[UILabel alloc] init];
        _footlab.frame = CGRectMake(14*WIDTH_SCALE, 0, kScreenW-28*WIDTH_SCALE, 50);
        _footlab.text = @"您的真实姓名和手机号平台会严格保密，仅有收到您礼物的亲友可以看到";
        _footlab.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _footlab.numberOfLines = 0;
        _footlab.font = [UIFont systemFontOfSize:14];

    }
    return _footlab;
}

-(UIView *)footview
{
    if(!_footview)
    {
        _footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150)];
        [_footview addSubview:self.footlab];
        _footview.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    }
    return _footview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return 4;
    }
    if (section==3) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        infoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid0];
        if (!cell) {
            cell = [[infoCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid0];
        }
        cell.nameLab.text = [self.dataDic objectForKey:@"name"];
        [cell.userImg sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"my_mrt"]] placeholderImage:[UIImage imageNamed:@"picture"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        infoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid1];
        if (!cell) {
            cell = [[infoCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            infoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid2];
            if (!cell) {
                cell = [[infoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid2];
            }
            cell.contentlab.text = [self.dataDic objectForKey:@"name"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==1) {
            infoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid3];
            if (!cell) {
                cell = [[infoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid3];
            }
            cell.leftlab.text = @"性别";
            NSString *sex = [self.dataDic objectForKey:@"sex"];
            if ([sex isEqualToString:@"0"]) {
                cell.contentlab.text = @"男";
            }
            if ([sex isEqualToString:@"1"])
            {
                cell.contentlab.text = @"女";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==2) {
            infoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid4];
            if (!cell) {
                cell = [[infoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid4];
            }
            cell.leftlab.text = @"年龄";
            cell.contentlab.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"old"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==3) {
            infoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid5];
            if (!cell) {
                cell = [[infoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid5];
            }
            cell.leftlab.text = @"地区";
            cell.contentlab.text = [self.dataDic objectForKey:@"addtess"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section==3) {
        infoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid6];
        if (!cell) {
            cell = [[infoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid6];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.leftlab.text = @"手机号";
            cell.contentlab.text = [self.dataDic objectForKey:@"username"];
        }
        if (indexPath.row==1) {
            cell.leftlab.text = @"真实姓名";
            cell.contentlab.text = [self.dataDic objectForKey:@"kname"];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140*HEIGHT_SCALE;
    }
    if (indexPath.section==1) {
        return 100*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            return 75*HEIGHT_SCALE;
        }
        else
        {
            return 45*HEIGHT_SCALE;
        }
    }
    if (indexPath.section==3) {
        return 45*HEIGHT_SCALE;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4*HEIGHT_SCALE;
}

@end
