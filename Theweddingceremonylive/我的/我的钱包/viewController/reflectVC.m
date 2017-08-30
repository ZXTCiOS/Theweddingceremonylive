//
//  reflectVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "reflectVC.h"
#import "rechargrCell0.h"
#import "reflectCell.h"

@interface reflectVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *selectBtn;
@end

static NSString *reflectidentfid0 = @"reflectidentfid0";
static NSString *reflectidentfid1 = @"reflectidentfid1";

@implementation reflectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请提现";
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
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


-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100*HEIGHT_SCALE)];
        [_footView addSubview:self.selectBtn];
    }
    return _footView;
}

-(UIButton *)selectBtn
{
    if(!_selectBtn)
    {
        _selectBtn = [[UIButton alloc] init];
        _selectBtn.frame = CGRectMake(20*WIDTH_SCALE, 40*HEIGHT_SCALE, kScreenW-40*WIDTH_SCALE, 48*HEIGHT_SCALE);
        [_selectBtn setTitle:@"提交申请" forState:normal];
        _selectBtn.layer.masksToBounds = YES;
        _selectBtn.layer.cornerRadius = 24*HEIGHT_SCALE;
        _selectBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_selectBtn addTarget:self action:@selector(selectbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}




#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        rechargrCell0 *cell = [tableView dequeueReusableCellWithIdentifier:reflectidentfid0];
        cell = [[rechargrCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reflectidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        reflectCell *cell = [tableView dequeueReusableCellWithIdentifier:reflectidentfid1];
        cell = [[reflectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reflectidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.leftlab.text = @"金额";
            cell.reflectext.placeholder = @"请输入提现金额";
            cell.reflectext.tag = 201;
            cell.reflectext.delegate = self;
        }
        if (indexPath.row==1) {
            cell.leftlab.text = @"持卡人";
            cell.reflectext.placeholder = @"请输入持卡人姓名";
            cell.reflectext.tag = 202;
            cell.reflectext.delegate = self;
        }
        if (indexPath.row==2) {
            cell.leftlab.text = @"身份证号";
            cell.reflectext.placeholder = @"请输入身份证号";
            cell.reflectext.tag = 203;
            cell.reflectext.delegate = self;
        }
        if (indexPath.row==3) {
            cell.leftlab.text = @"银行卡号";
            cell.reflectext.placeholder = @"请输入银行卡号";
            cell.reflectext.tag = 204;
            cell.reflectext.delegate = self;
        }
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100*HEIGHT_SCALE;
    }
    if (indexPath.section==1) {
        return 40*HEIGHT_SCALE;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)tabletap
{
    UITextField *text0 = [self.table viewWithTag:201];
    UITextField *text1 = [self.table viewWithTag:202];
    UITextField *text2 = [self.table viewWithTag:203];
    UITextField *text3 = [self.table viewWithTag:204];
    [text0 resignFirstResponder];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 实现方法

-(void)selectbtnclick
{
    
}

@end
