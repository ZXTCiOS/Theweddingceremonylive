//
//  perfectingViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectingViewController.h"
#import "perfectingCell0.h"
#import "perfectingCell1.h"
#import "perfectingCell2.h"
#import "BDImagePicker.h"
#import "MainTabBarController.h"


@interface perfectingViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate,myfinishdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) NSString *xinbiestr;
@end

static NSString *perfectidentfid0 = @"perfectidentfid0";
static NSString *perfectidentfid1 = @"perfectidentfid1";
static NSString *perfectidentfid2 = @"perfectidentfid2";
static NSString *perfectidentfid3 = @"perfectidentfid3";

@implementation perfectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善个人资料";
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
    self.table.tableFooterView = [UIView new];
    self.xinbiestr = @"0";
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid0];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid0];
            cell.lab.text = @"昵称";
            cell.text.placeholder = @"请输入昵称";
            cell.text.tag = 201;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        perfectingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid1];
        if (!cell) {
            cell = [[perfectingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid1];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid2];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid2];
            cell.lab.text = @"真实姓名";
            cell.tag = 202;
            cell.text.placeholder = @"请输入真实姓名";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        perfectingCell2 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid3];
        if (!cell) {
            cell = [[perfectingCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid3];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 110*HEIGHT_SCALE;
    }else
    {
        return 75*HEIGHT_SCALE;
    }
}

-(void)selectHeaderImage
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        self.userImg.image = image;
    }];
}

-(void)nanbtnClick:(UITableViewCell *)cell
{
    self.xinbiestr = @"0";
}

-(void)nvbtnClick:(UITableViewCell *)cell
{
    self.xinbiestr = @"1";
}

-(void)finishbtnClick:(UITableViewCell *)cell
{
    NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defa objectForKey:user_uid];
    UITextField *text0 = [self.table viewWithTag:201];
    UITextField *text1 = [self.table viewWithTag:202];
    NSString *suffix = @"png";
    UIImage *img = self.userImg.image;
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
    NSString *picture = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *name = @"";
    NSString *zname = @"";
    if (text0.text.length == 0) {
        name = @"";
    }
    else
    {
        name = text0.text;
    }
    
    if (text0.text.length == 0) {
        zname = @"";
    }
    else
    {
        zname = text1.text;
    }
    NSString *sex = self.xinbiestr;
    NSDictionary *para = @{@"uid":uid,@"suffix":suffix,@"picture":picture,@"name":name,@"sex":sex,@"zname":zname};
    [DNNetworking postWithURLString:post_edit parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
        }
        else if ([[obj objectForKey:@"code"] intValue]==999)
        {
            [MBProgressHUD showSuccess:@"未进行任何更新或者未知错误" toView:self.view];
        }else
        {
            [MBProgressHUD showSuccess:@"非法操作" toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
    
    
    //登录
    NSString *type = @"1";
    NSDictionary *teldic = @{@"user_tel":self.tel,@"user_pwd":self.pwd,@"type":type};
    [DNNetworking postWithURLString:post_login parameters:teldic success:^(id obj) {
        
        //切换根视图控制器
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *tokenstr = [dic objectForKey:@"token"];
            NSString *uidstr = [dic objectForKey:@"uid"];
            NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
            [defat setObject:tokenstr forKey:user_token];
            [defat setObject:uidstr forKey:user_uid];
            [defat synchronize];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainTabBarController * main = [[MainTabBarController alloc] init];
            appDelegate.window.rootViewController = main;
            
        }
        else
        {
            [MBProgressHUD showSuccess:@"密码错误" toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];

}
@end
