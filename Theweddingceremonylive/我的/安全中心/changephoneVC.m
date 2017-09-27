//
//  changephoneVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneVC.h"
#import "changeCell0.h"
#import "changeCell1.h"

@interface changephoneVC ()<UITableViewDataSource,UITableViewDelegate,mysubmitVdelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) NSString *codestr;
@end

static NSString *changephpneidentfid0 = @"changephpneidentfid0";
static NSString *changephpneidentfid1 = @"changephpneidentfid1";

@implementation changephoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手机号";
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    [self.view addSubview:self.submitBtn];
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
        _table.scrollEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
        [_table addGestureRecognizer:tap];
    }
    return _table;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"立即修改" forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.frame = CGRectMake(kScreenW/2-120*WIDTH_SCALE, 180*HEIGHT_SCALE, 240*WIDTH_SCALE, 45*HEIGHT_SCALE);
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 45/2*HEIGHT_SCALE;
        [_submitBtn addTarget:self action:@selector(sentbtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        changeCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changephpneidentfid0];
        if (!cell) {
            cell = [[changeCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephpneidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLab.text = @"手机号";
        cell.text.placeholder = @"请输入手机号";
        cell.text.delegate = self;
        cell.text.tag = 201;
        return cell;
    }
    if (indexPath.row==1) {
        changeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changephpneidentfid1];
        if (!cell) {
            cell = [[changeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephpneidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLab.text = @"验证码";
        cell.text.placeholder = @"请输入验证码";
        cell.text.delegate = self;
        cell.delegate = self;
        cell.text.tag = 202;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

#pragma mark - 实现方法


-(void)sentbtn
{
    UITextField *text = [self.table viewWithTag:202];
    
    if ([self.codestr isEqualToString:text.text])
    {
        UITextField *text1 = [self.table viewWithTag:201];
        NSString *tel = @"";
        if (text1.text.length==0) {
            tel = @"";
        }
        else
        {
            tel = text1.text;
        }
        NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
        NSString *uid = [userdefat objectForKey:user_uid];
        NSString *token = [userdefat objectForKey:user_token];
        NSDictionary *para = @{@"uid":uid,@"token":token,@"tel":tel};
        [DNNetworking postWithURLString:post_editphone parameters:para success:^(id obj) {
            NSString *hud = [obj objectForKey:@"mes"];
            [MBProgressHUD showSuccess:hud toView:self.view];
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
        }];
    }else
    {
        [MBProgressHUD showSuccess:@"请输入正确的验证码" toView:self.view];
    }
}

-(void)submitbtnClick:(UITableViewCell *)cell
{
    UITextField *text = [self.table viewWithTag:202];
    //验证码
    NSDictionary *para = @{@"phone":text.text};
    [DNNetworking postWithURLString:post_value parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"]isEqualToString:@"code"]) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.codestr = [dic objectForKey:@"code"];
            [MBProgressHUD showSuccess:@"请求成功" toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)tabletap
{
    UITextField *text1 = [self.table viewWithTag:201];
    UITextField *text2 = [self.table viewWithTag:202];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
