//
//  ModifyInfoVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ModifyInfoVC.h"
#import "BDImagePicker.h"
#import "perfectingCell0.h"
#import "perfectingCell1.h"
#import "modifyCell.h"

@interface ModifyInfoVC ()<UITableViewDelegate,UITableViewDataSource,mycellVdelegate,mysubmitVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *userImg;
@end

static NSString *modifyidentfid0 = @"modifyidentfid0";
static NSString *modifyidentfid1 = @"modifyidentfid1";
static NSString *modifyidentfid2 = @"modifyidentfid2";
static NSString *modifyidentfid3 = @"modifyidentfid3";
static NSString *modifyidentfid4 = @"modifyidentfid4";
static NSString *modifyidentfid5 = @"modifyidentfid5";

@implementation ModifyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改个人资料";
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    self.table.tableHeaderView = self.headView;
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
        [_table addGestureRecognizer:tap];
    }
    return _table;
}

-(UIView *)headView
{
    if(!_headView)
    {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150*HEIGHT_SCALE)];
        [_headView addSubview:self.userImg];
    }
    return _headView;
}

-(UIImageView *)userImg
{
    if(!_userImg)
    {
        _userImg = [[UIImageView alloc] init];
        _userImg.frame = CGRectMake(kScreenW/2-40*WIDTH_SCALE, 25*HEIGHT_SCALE, 80*WIDTH_SCALE, 80*WIDTH_SCALE);
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.cornerRadius = 40*WIDTH_SCALE;
        _userImg.image = [UIImage imageNamed:@"userpic"];
        _userImg.userInteractionEnabled = YES;
        //给图片添加点击手势（也可以添加其他手势）
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage)];
        [_userImg addGestureRecognizer:tap];

    }
    return _userImg;
}



#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid0];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid0];
            cell.lab.text = @"昵称";
            cell.text.placeholder = @"请输入昵称";
            cell.text.tag = 201;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        perfectingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid1];
        if (!cell) {
            cell = [[perfectingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid1];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    if (indexPath.row==2) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid2];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid2];
            cell.lab.text = @"年龄";
            cell.text.placeholder = @"请输入年龄";
            cell.text.tag = 202;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid3];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid3];
            cell.lab.text = @"地区";
            cell.text.placeholder = @"请输入地区";
            cell.text.tag = 203;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==4) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid4];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid4];
            cell.lab.text = @"个性签名";
            cell.text.placeholder = @"请输入个性签名";
            cell.text.tag = 204;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==5) {
        modifyCell *cell = [tableView dequeueReusableCellWithIdentifier:modifyidentfid5];
        if (!cell) {
            cell = [[modifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modifyidentfid5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        return 90*HEIGHT_SCALE;
    }
    else
    {
        return 75*HEIGHT_SCALE;
    }
}

#pragma mark - 实现方法
-(void)submitbtnClick:(UITableViewCell *)cell
{
    NSLog(@"完成");
}
-(void)nanbtnClick:(UITableViewCell *)cell
{
    
}

-(void)nvbtnClick:(UITableViewCell *)cell
{
    
}

-(void)setbtnclick
{
    NSLog(@"完成");
}

-(void)selectHeaderImage
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        self.userImg.image = image;
    }];
}

-(void)tabletap
{
    UITextField *text1 = [self.table viewWithTag:201];
    UITextField *text2 = [self.table viewWithTag:202];
    UITextField *text3 = [self.table viewWithTag:203];
    UITextField *text4 = [self.table viewWithTag:204];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
