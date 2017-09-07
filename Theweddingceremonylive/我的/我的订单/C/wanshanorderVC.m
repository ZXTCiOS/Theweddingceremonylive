//
//  wanshanorderVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wanshanorderVC.h"
#import "wanshanCell0.h"
#import "wanshanCell1.h"
#import "wanshanCell2.h"
#import "wanshanCell3.h"
#import "wanshanCell4.h"
#import "ZmjPickView.h"
#import "BDImagePicker.h"
#import "weddingcardVC.h"
#import "OYRAlertView.h"

@interface wanshanorderVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,OYRAlertViewDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (strong, nonatomic) ZmjPickView *zmjPickView;

@property (nonatomic,strong) OYRAlertView * oyrAlertView;

@property (nonatomic,strong) NSString *room_yangshi;
@property (nonatomic,strong) NSString *room_name;
@property (nonatomic,strong) NSString *room_img;
@property (nonatomic,strong) NSString *xitie_img;

@property (nonatomic,strong) NSString *room_address;
@property (nonatomic,strong) NSString *room_boy;
@property (nonatomic,strong) NSString *room_girl;
@property (nonatomic,strong) NSString *Delivery_address;
@property (nonatomic,strong) NSString *room_tel;
@property (nonatomic,strong) NSString *qinyouyaoqingma;
@end

static NSString *wanshanorderidentfid0 = @"wanshanorderidentfid0";
static NSString *wanshanorderidentfid1 = @"wanshanorderidentfid1";
static NSString *wanshanorderidentfid2 = @"wanshanorderidentfid2";
static NSString *wanshanorderidentfid3 = @"wanshanorderidentfid3";

static NSString *wanshanorderidentfid4 = @"wanshanorderidentfid4";
static NSString *wanshanorderidentfid5 = @"wanshanorderidentfid5";
static NSString *wanshanorderidentfid6 = @"wanshanorderidentfid6";
static NSString *wanshanorderidentfid7 = @"wanshanorderidentfid7";
static NSString *wanshanorderidentfid8 = @"wanshanorderidentfid8";
static NSString *wanshanorderidentfid9 = @"wanshanorderidentfid9";


@implementation wanshanorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善订单";
    if ([self.typestr isEqualToString:@"3"]) {
        
    }
    else
    {
        [self click];
    }
    
    self.room_yangshi = [self.orderdic objectForKey:@"room_yangshi"];
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    self.qinyouyaoqingma = [self.orderdic objectForKey:@"password"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)click{
    [self loadAlertView:self.yaoqingma contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"修改", nil] type:11];
}

-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password{
    switch (index) {
        case 101:
        {
            NSLog(@"Click ok");
            NSMutableArray *dataarr = self.oyrAlertView.pzxView.textFieldArray;
            NSString *str = [NSString string];
            for (int i = 0; i<dataarr.count; i++) {
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",(UITextField *)[dataarr[i] text]]];
            }
            NSLog(@"str---------%@",str);
            self.qinyouyaoqingma = str;
            
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
        wanshanCell0 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid0];
        if (!cell) {
            cell = [[wanshanCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid0];
            cell.wanshantext.tag = 201;
        }
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
        cell.wanshantext.text = [self.orderdic objectForKey:@"room_name"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        wanshanCell1 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid1];
        if (!cell) {
            cell = [[wanshanCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid1];
            cell.leftImg.tag = 301;
        }
        [cell.leftImg sd_setImageWithURL:[NSURL URLWithString:[self.orderdic objectForKey:@"room_img"]] placeholderImage:[UIImage imageNamed:@"16bi9"]];
        cell.leftImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftimg0click)];
        [cell.leftImg addGestureRecognizer:tap];
        
      
        
        UIImage *img = cell.leftImg.image;
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        self.room_img = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        wanshanCell2 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid2];
        if (!cell) {
            cell = [[wanshanCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid2];
            cell.leftImg.tag = 302;
        }
        [cell.leftImg sd_setImageWithURL:[NSURL URLWithString:[self.orderdic objectForKey:@"room_info_img"]] placeholderImage:[UIImage imageNamed:@"16bi9"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftimg1click)];
        [cell.leftImg addGestureRecognizer:tap];
        

        NSData *imageData = UIImageJPEGRepresentation(cell.leftImg.image, 1.0);
        self.xitie_img = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        return cell;
    }
    if (indexPath.row==3) {
        wanshanCell3 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid3];
        cell = [[wanshanCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid3];
        
        [cell.btn0 addTarget:self action:@selector(typebtn0click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn1 addTarget:self action:@selector(typebtn1click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(typebtn2click) forControlEvents:UIControlEventTouchUpInside];
        [cell setdatabtn:[self.orderdic objectForKey:@"room_yangshi"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==4) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid4];
        //        if (!cell) {
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid4];
        //            cell.wanshantext.tag = 202;
        //        }
        self.room_address = [self.orderdic objectForKey:@"room_address"];
        cell.wanshantext.text = self.room_address;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"婚礼地址";
        cell.wanshantext.enabled = NO;
        cell.wanshantext.placeholder = @"请输入所在省份和城市";
        cell.wanshantext.delegate = self;
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    if (indexPath.row==5) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid5];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"新郎姓名";
        cell.wanshantext.placeholder = @"请输入新郎姓名";
        cell.wanshantext.text = [self.orderdic objectForKey:@"room_boy"];
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 203;
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    if (indexPath.row==6) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid6];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid6];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"新娘姓名";
        cell.wanshantext.placeholder = @"请输入新娘姓名";
        cell.wanshantext.text = [self.orderdic objectForKey:@"room_girl"];
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 204;
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    if (indexPath.row==7) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid7];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid7];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"收货地址";
        cell.wanshantext.placeholder = @"请输入详细地址";
        cell.wanshantext.text = [self.orderdic objectForKey:@"delivery_address"];
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 205;
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    if (indexPath.row==8) {
        wanshanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:wanshanorderidentfid8];
        cell = [[wanshanCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wanshanorderidentfid8];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typelab.text = @"手机号码";
        cell.wanshantext.placeholder = @"请输入手机号码";
        cell.wanshantext.text = [self.orderdic objectForKey:@"room_tel"];
        cell.wanshantext.delegate = self;
        cell.wanshantext.tag = 206;
        cell.wanshantext.textAlignment = NSTextAlignmentRight;
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
            
            weakSelf.room_address = [NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName];
            [weakSelf.table reloadData];
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
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    
    UITextField *textname = [self.table viewWithTag:201];
    NSString *room_name;
    if (textname.text.length==0) {
        room_name = @"";
    }
    else
    {
        room_name = textname.text;
    }
    NSString *suffix1 = @"png";
    NSString *suffix2 = @"png";
    
    UITextField *boytext = [self.table viewWithTag:203];
    UITextField *girltext = [self.table viewWithTag:204];
    
    NSString *room_boy = [[NSString alloc] init];
    NSString *room_girl = [[NSString alloc] init];
    
    if (boytext.text.length==0) {
        room_boy = @"";
    }
    else
    {
        room_boy = boytext.text;
    }
    if (girltext.text.length==0) {
        room_girl = @"";
    }
    else
    {
        room_girl = girltext.text;
    }
    
    UITextField *Delivery_addresstext = [self.table viewWithTag:205];
    NSString *Delivery_address = [[NSString alloc] init];
    if (Delivery_addresstext.text.length==0) {
        Delivery_address = @"";
    }
    else
    {
        Delivery_address = Delivery_addresstext.text;
    }
    
    UITextField *teltext = [self.table viewWithTag:206];
    NSString *room_tel = [[NSString alloc] init];
    if (teltext.text.length==0) {
        room_tel = @"";
    }
    else
    {
        room_tel =teltext.text;
    }
    
    NSString *order_id = [self.orderdic objectForKey:@"ordernb"];
    
    NSDictionary *para = @{@"uid":uid,@"token":token,@"ordernb":order_id,@"room_name":room_name,@"room_img":self.room_img,@"suffix1":suffix1,@"xitie_img":self.xitie_img,@"suffix2":suffix2,@"room_yangshi":self.room_yangshi,@"room_address":self.room_address,@"room_boy":room_boy,@"room_girl":room_girl,@"Delivery_address":Delivery_address,@"room_tel":room_tel,@"p_assword":self.qinyouyaoqingma};

    [DNNetworking postWithURLString:post_finish_order_info parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            weddingcardVC *vc = [[weddingcardVC alloc] init];
            vc.order_id = order_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(void)typebtn0click
{
    
    self.room_yangshi = @"1";
}

-(void)typebtn1click
{
    
    self.room_yangshi = @"2";
}

-(void)typebtn2click
{
    
    self.room_yangshi = @"3";
}


-(void)leftimg0click
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        UIImageView *leftimg = [self.table viewWithTag:301];
        leftimg.image = image;
        
        UIImage *img = leftimg.image;
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        self.room_img = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        [self.table reloadData];
    }];
}

-(void)leftimg1click
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        UIImageView *leftimg = [self.table viewWithTag:302];
        leftimg.image = image;
        
        UIImage *img = leftimg.image;
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        self.xitie_img = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
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
