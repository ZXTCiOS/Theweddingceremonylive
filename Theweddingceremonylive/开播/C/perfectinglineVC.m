//
//  perfectinglineVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectinglineVC.h"
#import "wanshanCell0.h"
#import "wanshanCell1.h"
#import "wanshanCell2.h"
#import "wanshanCell3.h"
#import "wanshanCell4.h"
#import "ZmjPickView.h"
#import "BDImagePicker.h"
#import "weddingcardVC.h"
#import "OYRAlertView.h"

@interface perfectinglineVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,OYRAlertViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (strong, nonatomic) ZmjPickView *zmjPickView;

@property (nonatomic,strong) OYRAlertView * oyrAlertView;
@end

static NSString *wanshanidentfid0 = @"wanshanidentfid0";
static NSString *wanshanidentfid1 = @"wanshanidentfid1";
static NSString *wanshanidentfid2 = @"wanshanidentfid2";
static NSString *wanshanidentfid3 = @"wanshanidentfid3";

static NSString *wanshanidentfid4 = @"wanshanidentfid4";
static NSString *wanshanidentfid5 = @"wanshanidentfid5";
static NSString *wanshanidentfid6 = @"wanshanidentfid6";
static NSString *wanshanidentfid7 = @"wanshanidentfid7";
static NSString *wanshanidentfid8 = @"wanshanidentfid8";
static NSString *wanshanidentfid9 = @"wanshanidentfid9";


@implementation perfectinglineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善信息";
    [self click];
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)click{
    [self loadAlertView:@"初始邀请码" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确认", nil] type:11];
    
}

-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password{
    switch (index) {
        case 101:
        {
            NSLog(@"Click ok");
//            UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您输入的密码" message:[NSString stringWithFormat:@"%@",self.oyrAlertView.pzxView.vertificationCode] preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"%@",self.oyrAlertView.pzxView.textFieldArray);
        }
            break;
        case 100:
            NSLog(@"Click cancle");
            
            break;
        default:
            break;
    }
}


- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{
    
    OYRAlertView *alertView = [[OYRAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    self.oyrAlertView = alertView;
    
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
//        _table.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
//        [_table addGestureRecognizer:tap];
    }
    return _table;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100*HEIGHT_SCALE)];
        [_footView addSubview:self.submitBtn];
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.frame = CGRectMake(kScreenW/2-125*WIDTH_SCALE, 30*HEIGHT_SCALE, 250*WIDTH_SCALE, 50*HEIGHT_SCALE);
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_submitBtn setTitle:@"确认" forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (ZmjPickView *)zmjPickView {
    if (!_zmjPickView) {
        _zmjPickView = [[ZmjPickView alloc]init];
    }
    return _zmjPickView;
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        wanshanCell0 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid0];
        cell = [[wanshanCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid0];
        cell.wanshantext.tag = 201;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        wanshanCell1 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid1];
        if (!cell) {
            cell = [[wanshanCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid1];
            cell.leftImg.tag = 301;
        }
      
        
        cell.leftImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftimg0click)];
        [cell.leftImg addGestureRecognizer:tap];
        

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        wanshanCell2 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid2];
        if (!cell) {
            cell = [[wanshanCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid2];
            cell.leftImg.tag = 302;
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftimg1click)];
        [cell.leftImg addGestureRecognizer:tap];
        
        return cell;
    }
    if (indexPath.row==3) {
        wanshanCell3 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid3];
        cell = [[wanshanCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid3];
        
        [cell.btn0 addTarget:self action:@selector(typebtn0click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn1 addTarget:self action:@selector(typebtn1click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(typebtn2click) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==4) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid4];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"婚礼地址";
        cell.wanshantext.enabled = NO;
        cell.wanshantext.placeholder = @"请输入所在省份和城市";
        cell.wanshantext.delegate = self;
        return cell;
    }
    if (indexPath.row==5) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid5];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"新郎姓名";
        cell.wanshantext.placeholder = @"请输入新郎姓名";
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 203;
        return cell;
    }
    if (indexPath.row==6) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid6];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid6];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"新娘姓名";
        cell.wanshantext.placeholder = @"请输入新娘姓名";
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 204;
        return cell;
    }
    if (indexPath.row==7) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid7];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid7];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"收货地址";
        cell.wanshantext.placeholder = @"请输入详细地址";
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 205;
        return cell;
    }
    if (indexPath.row==8) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanidentfid8];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanidentfid8];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"手机号码";
        cell.wanshantext.placeholder = @"请输入手机号码";
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 206;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 80*HEIGHT_SCALE;
    }
    if (indexPath.row==2) {
        return 80*HEIGHT_SCALE;
    }
    if (indexPath.row==3) {
        return 50*HEIGHT_SCALE;
    }
    else
    {
        return 50*HEIGHT_SCALE;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        [self zmjPickView];
        
        [_zmjPickView show];
        
        __weak typeof(self) weakSelf = self;
        _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf ShengId:shengId ShiId:shiId XianId:xianId];
            [strongSelf ShengName:shengName ShiName:shiName XianName:xianName];
        };
    }
}
- (void)ShengId:(NSInteger)shengId ShiId:(NSInteger)shiId XianId:(NSInteger)xianId{
    
    NSLog(@"%ld,%ld,%ld",shengId,shiId,xianId);
}

- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
    
    NSLog(@"%@,%@,%@",shengName,shiName,xianName);
    
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    weddingcardVC *vc = [[weddingcardVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)typebtn0click
{
    [MBProgressHUD showSuccess:@"111111"];
}

-(void)typebtn1click
{
    [MBProgressHUD showSuccess:@"222222"];
}

-(void)typebtn2click
{
    [MBProgressHUD showSuccess:@"333333"];
}


-(void)leftimg0click
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        UIImageView *leftimg = [self.table viewWithTag:301];
        leftimg.image = image;
        [self.table reloadData];
    }];
}

-(void)leftimg1click
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        UIImageView *leftimg = [self.table viewWithTag:302];
        leftimg.image = image;
        [self.table reloadData];
    }];
}

-(void)tabletap
{
    UITextField *text0 = [self.table viewWithTag:201];
    //UITextField *text1 = [self.table viewWithTag:202];
    UITextField *text2 = [self.table viewWithTag:203];
    UITextField *text3 = [self.table viewWithTag:204];
    UITextField *text4 = [self.table viewWithTag:205];
    UITextField *text5 = [self.table viewWithTag:206];
    [text0 resignFirstResponder];
//    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
    
}

#pragma mark - tabbar

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
