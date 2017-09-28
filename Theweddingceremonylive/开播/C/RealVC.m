//
//  RealVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "RealVC.h"
#import "realCell.h"
#import "readheadView.h"
#import "realfootView.h"
#import "BDImagePicker.h"

@interface RealVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) readheadView *headView;
@property (nonatomic,strong) realfootView *footView;


@end

static NSString *realidentfid = @"realidentfid";

@implementation RealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实名认证";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
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
//        _table.userInteractionEnabled = NO;
    }
    return _table;
}

-(readheadView *)headView
{
    if(!_headView)
    {
        _headView = [[readheadView alloc] init];
        _headView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        _headView.frame = CGRectMake(0, 0, kScreenW, 240*HEIGHT_SCALE);
    }
    return _headView;
}

-(realfootView *)footView
{
    if(!_footView)
    {
        _footView = [[realfootView alloc] init];
        _footView.frame = CGRectMake(0, 0, kScreenW, 250*HEIGHT_SCALE);
        _footView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
//        _footView.userInteractionEnabled = NO;
        [_footView.submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_footView.leftimg.addBtn addTarget:self action:@selector(leftaddimgclick) forControlEvents:UIControlEventTouchUpInside];
        [_footView.rightimg.addBtn addTarget:self action:@selector(rightaddimgclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    realCell *cell = [tableView dequeueReusableCellWithIdentifier:realidentfid];
    cell = [[realCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.leftLab.text = @"真实姓名";
        cell.realText.placeholder = @"请输入真实姓名";
        cell.realText.delegate = self;
        cell.realText.tag = 201;
    }
    if (indexPath.row==1) {
        cell.leftLab.text = @"身份证号";
        cell.realText.placeholder = @"请输入身份证号";
        cell.realText.delegate = self;
        cell.realText.tag = 202;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    NSLog(@"submit");
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    UITextField *text1 = [self.table viewWithTag:201];
    UITextField *text2 = [self.table viewWithTag:202];
    NSString *name = [NSString new];
    NSString *idcard = [NSString new];
    if (text1.text.length==0) {
        name = @"";
    }
    else
    {
        name = text1.text;
    }
    if (text2.text.length==0) {
        idcard = @"";
    }
    else
    {
        idcard = text2.text;
    }
    NSString *pic1 = [NSString new];
    NSString *pic2 = [NSString new];
    
    UIImage *imgleft = self.footView.leftimg.image;
    NSData *imageData = UIImageJPEGRepresentation(imgleft, 1.0);
    pic1 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImage *imgright = self.footView.rightimg.image;
    NSData *imageData2 = UIImageJPEGRepresentation(imgright, 1.0);
    pic2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *suffix1 = @"png";
    NSString *suffix2 = @"png";
    
    if (pic1.length!=0&&pic2.length!=0) {
        NSDictionary *para = @{@"uid":uid,@"token":token,@"name":name,@"idcard":idcard,@"pic1":pic1,@"pic2":pic2,@"suffix1":suffix1,@"suffix2":suffix2};
        [DNNetworking postWithURLString:post_renzheng parameters:para success:^(id obj) {
            NSString *msg = [obj objectForKey:@"msg"];
            [MBProgressHUD showSuccess:msg];
            if ([[obj objectForKey:@"code"] intValue]==1000) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
        }];
    }
    else
    {
        [MBProgressHUD showSuccess:@"请选择图片" toView:self.view];
    }

    
    
}

-(void)leftaddimgclick
{
    NSLog(@"leftimg");
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        self.footView.leftimg.image = image;
    }];
}

-(void)rightaddimgclick
{
    NSLog(@"rightimg");
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        self.footView.rightimg.image = image;
    }];
}

#pragma mark - 生命周期函数

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

-(void)backAction
{
     self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}
@end
