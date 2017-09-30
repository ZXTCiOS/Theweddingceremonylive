//
//  rechargeVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rechargeVC.h"
#import "rechargrCell0.h"
#import "chongzhifootView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface rechargeVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) chongzhifootView *fview;
@property (nonatomic,strong) NSString *type;
@end

static NSString *rechargeidentfid0 = @"rechargeidentfid0";

@implementation rechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值";
    self.type = @"1";
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.fview;
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
        [_table addGestureRecognizer:tap];
    }
    return _table;
}

-(chongzhifootView *)fview
{
    if(!_fview)
    {
        _fview = [[chongzhifootView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 500)];
        _fview.backgroundColor = [UIColor whiteColor];
        _fview.moneytext.delegate = self;
        [_fview.btn0 addTarget:self action:@selector(zhifubaoclick) forControlEvents:UIControlEventTouchUpInside];
        [_fview.btn1 addTarget:self action:@selector(weixinclick) forControlEvents:UIControlEventTouchUpInside];
        [_fview.sendBtn addTarget:self action:@selector(sendBtnclcik) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _fview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rechargrCell0 *cell = [tableView dequeueReusableCellWithIdentifier:rechargeidentfid0];
    cell = [[rechargrCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rechargeidentfid0];
    cell.moneyLab.text = [NSString stringWithFormat:@"%@%@",@"余额：¥",self.moneystr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

-(void)tabletap
{
    [self.fview.moneytext resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)sendBtnclcik
{
    if ([self.type isEqualToString:@"1"]) {
        [self zhifu];
    }
    else
    {
        [MBProgressHUD showSuccess:@"微信支付暂未开通，敬请期待" toView:self.view];

    }
}

-(void)zhifu
{

    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSString *user_wallet = @"";
    if (self.fview.moneytext.text.length==0) {
        user_wallet = @"";
        [MBProgressHUD showSuccess:@"请输入充值金额" toView:self.view];
    }
    else
    {
        
    
        
        
        user_wallet=  self.fview.moneytext.text;
        NSDictionary *para = @{@"uid":uid,@"token":token,@"user_wallet":user_wallet};

        [DNNetworking postWithURLString:post_chongshi parameters:para success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==1000) {
                NSDictionary *dic = [obj objectForKey:@"data"];
                NSString *idstr = [dic objectForKey:@"id"];
                NSString *str = [dic objectForKey:@"zhifubao"];
                NSString *appScheme = @"zhifubaozhifubaozhifubao";
                NSString *orderString = str;
                NSString *price = user_wallet;
                
                    // NOTE: 调用支付结果开始支付
                    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        NSString * memo = resultDic[@"memo"];
                        NSLog(@"===memo:%@", memo);
                        if ([resultDic[@"ResultStatus"] isEqualToString:@"9000"]) {

                            NSDictionary *dict = @{@"uid":uid,@"token":token,@"id":idstr,@"price":price,@"type":@"1"};
                            [DNNetworking postWithURLString:post_chongzhichuli parameters:dict success:^(id obj) {
                                if ([[obj objectForKey:@"code"] intValue]==1000) {
                                    [MBProgressHUD showSuccess:@"充值成功" toView:self.view];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            } failure:^(NSError *error) {
                                
                            }];
                        }else{
                            NSDictionary *dict = @{@"uid":uid,@"token":token,@"id":idstr,@"price":price,@"type":@"0"};
                            [DNNetworking postWithURLString:post_chongzhichuli parameters:dict success:^(id obj) {
                                
                            } failure:^(NSError *error) {
                                
                            }];
                        }
                    }];
            }
            else
            {
                NSString *msg = [obj objectForKey:@"msg"];
                [MBProgressHUD showSuccess:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
        }];
    }
}

#pragma mark - 实现方法

-(void)zhifubaoclick
{
    self.fview.btn0.layer.borderColor = [UIColor colorWithHexString:@"ed5e40"].CGColor;
    self.fview.btn1.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    [self.fview.btn0.rightimg setHidden:NO];
    [self.fview.btn1.rightimg setHidden:YES];
    self.type = @"1";
}

-(void)weixinclick
{
    self.fview.btn1.layer.borderColor = [UIColor colorWithHexString:@"ed5e40"].CGColor;
    self.fview.btn0.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    [self.fview.btn1.rightimg setHidden:NO];
    [self.fview.btn0.rightimg setHidden:YES];
    self.type = @"2";
}

@end
