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
    self.title = @"实名认证";

    
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
    }
    if (indexPath.row==1) {
        cell.leftLab.text = @"身份证号";
        cell.realText.placeholder = @"请输入身份证号";
        cell.realText.delegate = self;
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

@end
