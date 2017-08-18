//
//  changepwdVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changepwdVC.h"
#import "changeCell0.h"

@interface changepwdVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIButton *submitBtn;
@end

static NSString *changepwdidentfid0 = @"changepwdidentfid0";
static NSString *changepwdidentfid1 = @"changepwdidentfid1";

@implementation changepwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录密码";
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
        changeCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changepwdidentfid0];
        if (!cell) {
            cell = [[changeCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepwdidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLab.text = @"新密码";
        cell.text.keyboardType = UIKeyboardTypeDefault;
        cell.text.placeholder = @"请输入新密码";
        cell.text.tag = 201;
        cell.text.delegate = self;
        cell.text.secureTextEntry = YES;
        return cell;
    }
    if (indexPath.row==1) {
        changeCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changepwdidentfid1];
        if (!cell) {
            cell = [[changeCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepwdidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLab.text = @"确认新密码";
        cell.text.keyboardType = UIKeyboardTypeDefault;
        cell.text.placeholder = @"请输入新密码";
        cell.text.tag = 202;
        cell.text.delegate = self;
        cell.text.secureTextEntry = YES;
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
    UITextField *text1 = [self.table viewWithTag:201];
    UITextField *text2 = [self.table viewWithTag:202];
    
    if (text1.text.length==0||text2.text.length==0) {
        [MBProgressHUD showSuccess:@"请输入密码"];
    }
    if (text1.text.length!=0&&text2.text.length!=0) {
        
        if ([text1.text isEqualToString:text2.text]) {
            [MBProgressHUD showSuccess:@"输入正确"];
            NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
            NSString *uid = [defat objectForKey:user_uid];
            NSString *token = [defat objectForKey:user_token];
            NSString *pwd = text1.text;
            NSDictionary *para = @{@"uid":uid,@"token":token,@"pwd":pwd};
            [DNNetworking postWithURLString:post_editpwd parameters:para success:^(id obj) {
                NSString *mes = [obj objectForKey:@"mes"];
                [MBProgressHUD showSuccess:mes];
            } failure:^(NSError *error) {
                [MBProgressHUD showSuccess:@"没有网络"];
            }];
        }
        else
        {
            [MBProgressHUD showSuccess:@"两次密码必须保持一致"];
        }
    }
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
