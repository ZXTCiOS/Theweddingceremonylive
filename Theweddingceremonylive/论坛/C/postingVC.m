//
//  postingVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postingVC.h"
#import "postCell0.h"
#import "postCell1.h"
#import <CoreLocation/CoreLocation.h>

@interface postingVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,HXPhotoViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSString *imgstr0;
@property (nonatomic,copy) NSString *imgstr1;
@property (nonatomic,copy) NSString *imgstr2;
@end

static NSString *postidentfid0 = @"postidentfid0";
static NSString *postidentfid1 = @"postidentfid1";

@implementation postingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发帖";
    [self locate];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
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
        _table.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
//        [_table addGestureRecognizer:tap];
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        postCell0 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid0];
        if (!cell) {
            cell = [[postCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid0];
            cell.titletext.tag = 202;
        }
        cell.titletext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        postCell1 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid1];
        if (!cell) {
            cell = [[postCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid1];
            cell.photoView.delegate = self;
            cell.textView.tag = 203;
        }
        cell.textView.delegate = self;
        [cell.submitBtn addTarget:self action:@selector(sendbtnclick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 220*HEIGHT_SCALE;
    }
    return 0.01f;
}

-(void)sendbtnclick
{
    NSLog(@"str-----%@%@%@",self.imgstr0,self.imgstr1,self.imgstr2);
    
    
    
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefault objectForKey:user_uid];
    NSString *token = [userdefault objectForKey:user_token];
    
    NSString *picture1 = @"";
    NSString *picture2 = @"";
    NSString *picture3 = @"";
    
    if ([strisNull isNullToString:self.imgstr0]) {
        picture1 = @"";
    }
    else
    {
        picture1 = self.imgstr0;
    }
    if ([strisNull isNullToString:self.imgstr1]) {
        picture2 = @"";
    }
    else
    {
        picture2 = self.imgstr1;
    }
    if ([strisNull isNullToString:self.imgstr2]) {
        picture3 = @"";
    }
    else
    {
        picture3 = self.imgstr2;
    }
    NSString *suffix1 = @"png";
    NSString *suffix2 = @"png";
    NSString *suffix3 = @"png";
    
    UITextField *text1 = [self.table viewWithTag:202];
    UITextView *text2 = [self.table viewWithTag:203];
    
    NSString *title = @"";
    NSString *content = @"";
    
    if (text1.text.length==0) {
        title = @"";
    }
    else
    {
        title = text1.text;
    }
    if (text2.text.length==0) {
        content = @"";
    }
    else
    {
        content = text2.text;
    }
    NSString *address = @"";
    
    if ([strisNull isNullToString:currentCity]) {
        currentCity = @"";
        address = @"北京";
    }
    else if ([currentCity isEqualToString:@"黑龙江省"]||[currentCity isEqualToString:@"内蒙古自治区"])
    {
        address= [currentCity substringToIndex:2];
    }
    else
    {
        address= [currentCity substringToIndex:3];
//        address = currentCity;
    }
    NSDictionary *para = @{@"uid":uid,@"token":token,@"picture1":picture1,@"picture2":picture2,@"picture3":picture3,@"suffix1":suffix1,@"suffix2":suffix2,@"suffix3":suffix3,@"title":title,@"content":content,@"address":address};
    [DNNetworking postWithURLString:post_fatie parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD showSuccess:msg];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"发帖失败"];
    }];
}

#pragma mark - 实现方法

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
   // NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    
  
   [HXPhotoTools getSelectedListResultModel:allList complete:^(NSArray<HXPhotoResultModel *> *alls, NSArray<HXPhotoResultModel *> *photos, NSArray<HXPhotoResultModel *> *videos) {
        NSSLog(@"\n全部类型:%@\n照片:%@\n视频:%@",alls,photos,videos);
       if (photos.count==1) {
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
       }
       if (photos.count==2) {
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
           
           
           HXPhotoResultModel *model1 = [photos objectAtIndex:1];
           UIImage *img1 = model1.displaySizeImage;
           NSData *imageData1 = UIImageJPEGRepresentation(img1, 1.0);
           NSString *picture1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr1 = picture1;
       }
       if (photos.count==3) {
           
           
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
           
           
           HXPhotoResultModel *model1 = [photos objectAtIndex:1];
           UIImage *img1 = model1.displaySizeImage;
           NSData *imageData1 = UIImageJPEGRepresentation(img1, 1.0);
           NSString *picture1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr1 = picture1;
           
           HXPhotoResultModel *model2 = [photos objectAtIndex:2];
           UIImage *img2 = model2.displaySizeImage;
           NSData *imageData2 = UIImageJPEGRepresentation(img2, 1.0);
           NSString *picture2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr2 = picture2;
           
       }
      
       if (photos.count==0) {
           self.imgstr0 = @"";
           self.imgstr1 = @"";
           self.imgstr2 = @"";
       }
    }];
    
}


- (void)locate {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager startUpdatingLocation];
    }
    
}

#pragma mark CoreLocation delegate

//定位失败则执行此代理方法
//定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.administrativeArea;
            

            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            NSLog(@"%@",currentCity); //这就是当前的城市
            
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}


#pragma mark - delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
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

-(void)tabletap
{
    UITextField *text1 = [self.table viewWithTag:202];
    UITextView *text2 = [self.table viewWithTag:203];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}
@end
