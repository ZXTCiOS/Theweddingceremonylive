//
//  BBSVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BBSVC.h"
#import "hotVC.h"
#import "qualityVC.h"
#import "localVC.h"
#import "LKSegmentController.h"
#import "addressVC.h"
#import <CoreLocation/CoreLocation.h>
#import "postingVC.h"

@interface BBSVC ()<CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
    UIBarButtonItem *item3;
    
}
@property (nonatomic,strong) LKSegmentController *segmentBarVC;
@property (nonatomic,strong) NSString *addressstr;
@end

@implementation BBSVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.topItem.title = @"论坛";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
    
    self.addressstr = @"北京";
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forum_address"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction2)];
    item3 = [[UIBarButtonItem alloc] initWithTitle:_addressstr style:UIBarButtonItemStylePlain target:self action:nil];
    item1.tintColor = [UIColor colorWithHexString:@"E95F46"];
    item3.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:item1,item3,nil];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forum_publish"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    
    LKSegmentController *segmentBarVc = [[LKSegmentController alloc] init];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVC = segmentBarVc;
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 250, 35);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    self.segmentBarVC.contentViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.segmentBarVC.view];
    hotVC *vc1 = [[hotVC alloc] init];
    qualityVC *vc2 = [[qualityVC alloc] init];
    localVC *vc3 = [[localVC alloc] init];
    vc3.address = self.addressstr;
    [self.segmentBarVC setUpWithItems:@[@"热点", @"精品", @"本地"] childViewControllers:@[vc1, vc2, vc3]];
    [self.segmentBarVC.segmentBar segmentBarStyle:^(LKSegmentBarStyle *barStyle) {
        barStyle.backgroundColor = [UIColor clearColor];
        barStyle.indicatorExtraW = 2;
        barStyle.indicatorHeight = 2;
        barStyle.backgroundColor = [UIColor whiteColor];
        barStyle.itemNormalColor = [UIColor colorWithHexString:@"333333"];
        barStyle.itemSelectColor = [UIColor colorWithHexString:@"ed5e40"];
        barStyle.indicatorColor = [UIColor colorWithHexString:@"ed5e40"];
    }];

    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    tag.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tag];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction2
{
    addressVC *addvc = [[addressVC alloc] init];
    addvc.returnString = ^(NSString * str){
        NSLog(@"%@",str);
        self.addressstr = str;
        item3.title = self.addressstr;
    };
    [self.navigationController pushViewController:addvc animated:YES];
}

-(void)addAction
{
    postingVC *vc = [[postingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self locate];
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
            NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
            
            if ([currentCity isEqualToString:@"黑龙江省"]||[currentCity isEqualToString:@"内蒙古自治区"]) {
                self.addressstr= [currentCity substringToIndex:2];
            }
            else
            {
                self.addressstr= [currentCity substringToIndex:2];
            }

           // self.addressstr = currentCity;
            
            item3.title = self.addressstr;
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}


@end
