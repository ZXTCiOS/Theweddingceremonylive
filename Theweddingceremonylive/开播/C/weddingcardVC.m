//
//  weddingcardVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingcardVC.h"
#import "ActionSheetView.h"
//#import "pilotliveVC.h"
#import "ZTVendorManager.h"
#import "QRcodeTool.h"
#import "PreLiveVC.h"

@interface weddingcardVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *bgImage;
@property (nonatomic,strong) UIImageView *typeImg;
@property (nonatomic,strong) UIImageView *headimg;

@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UIImageView *rightimg;
@property (nonatomic,strong) UILabel *leftLab;
@property (nonatomic,strong) UILabel *rightLab;

@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@property (nonatomic,strong) UILabel *lab5;
@property (nonatomic,strong) UILabel *lab6;
@property (nonatomic,strong) UILabel *lab7;


@property (nonatomic,strong) NSString *imgstr;
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *timestr;
@property (nonatomic,strong) NSString *yaoqingmastr;

@property (nonatomic, strong) ZTVendorPayManager *payManager;
@end

@implementation weddingcardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightbtn0 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xitie_share"] style:UIBarButtonItemStylePlain target:self action:@selector    (rightbtn0click)];
    [rightbtn0 setTintColor:[UIColor colorWithHexString:@"E95F46"]];
    UIBarButtonItem *rightbtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shibo"] style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn1click)];
     [rightbtn1 setTintColor:[UIColor colorWithHexString:@"E95F46"]];
     [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightbtn0,rightbtn1,nil]];
    
    
    self.title = @"喜帖";
    
    [self.view addSubview:self.scroll];
    [self.scroll addSubview:self.headimg];
    [self.scroll addSubview:self.typeImg];
    [self.scroll addSubview:self.nameLab];
    
    [self.scroll addSubview:self.leftimg];
    [self.scroll addSubview:self.rightimg];
    [self.scroll addSubview:self.leftLab];
    [self.scroll addSubview:self.rightLab];
    
    [self.scroll addSubview:self.lab0];
    [self.scroll addSubview:self.lab1];
    [self.scroll addSubview:self.lab2];
    [self.scroll addSubview:self.lab3];
    [self.scroll addSubview:self.lab4];
    [self.scroll addSubview:self.lab5];
    [self.scroll addSubview:self.lab6];
    [self.scroll addSubview:self.lab7];
    
    [self loaddata];
    self.payManager = [[ZTVendorPayManager alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token,@"ordernb":self.order_id};
    
    [DNNetworking postWithURLString:post_getxitie parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *datadic = [obj objectForKey:@"data"];
            NSString *room_boy = [datadic objectForKey:@"room_boy"];
            NSString *room_girl = [datadic objectForKey:@"room_girl"];
            self.namestr = [NSString stringWithFormat:@"%@%@%@",room_boy,@"&",room_girl];
            self.imgstr = [datadic objectForKey:@"room_info_img"];
            self.timestr = [datadic objectForKey:@"create_time"];
            NSString *password = [datadic objectForKey:@"password"];
            self.yaoqingmastr = [NSString stringWithFormat:@"%@%@",@"亲友邀请码:",password];
            [_headimg sd_setImageWithURL:[NSURL URLWithString:self.imgstr]];
            _nameLab.text = self.namestr;
            _lab7.text = self.yaoqingmastr;
            
            NSString *str = self.timestr;
            NSInteger inter = [str intValue];
            _lab2.text = [self timestampSwitchTime:inter andFormatter:@"YYYY-MM-dd hh:mm:ss"];
            
            NSString *url1str = [datadic objectForKey:@"url1"];
            NSString *url2str = [datadic objectForKey:@"url1"];
            
            self.leftimg.image = [QRcodeTool QRcodeToolgeneratedDataString:url1str imageViewWidth:150];
            self.rightimg.image = [QRcodeTool QRcodeToolgeneratedDataString:url2str imageViewWidth:150];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
}

#pragma mark - getters

-(UIScrollView *)scroll
{
    if(!_scroll)
    {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scroll.delegate = self;
        _scroll.contentSize = CGSizeMake(kScreenW, 1050*HEIGHT_SCALE+50);
        _scroll.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:self.bgImage];
    }
    return _scroll;
}

-(UIImageView *)bgImage
{
    if(!_bgImage)
    {
        _bgImage = [[UIImageView alloc] init];
        _bgImage.frame = CGRectMake(0, 0, kScreenW, 1050*HEIGHT_SCALE);
        _bgImage.image = [UIImage imageNamed:@"xitie"];
    }
    return _bgImage;
}

-(UIImageView *)typeImg
{
    if(!_typeImg)
    {
        _typeImg = [[UIImageView alloc] init];
        _typeImg.frame = CGRectMake(15*WIDTH_SCALE, 150*HEIGHT_SCALE, kScreenW-30*WIDTH_SCALE, kScreenW-30*WIDTH_SCALE-20*HEIGHT_SCALE);
        _typeImg.image = [UIImage imageNamed:@"xitie_pho"];
    }
    return _typeImg;
}

-(UIImageView *)headimg
{
    if(!_headimg)
    {
        _headimg = [[UIImageView alloc] init];
        _headimg.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 200*HEIGHT_SCALE, 220*WIDTH_SCALE, 220*WIDTH_SCALE);
        _headimg.layer.masksToBounds = YES;
       // _headimg.backgroundColor = [UIColor orangeColor];
        _headimg.layer.cornerRadius = 110*WIDTH_SCALE;

 
    }
    return _headimg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.frame = CGRectMake(100*WIDTH_SCALE, 380*HEIGHT_SCALE, 200*WIDTH_SCALE, 50);
        _nameLab.font = [UIFont systemFontOfSize:18];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.textColor = [UIColor colorWithHexString:@"ffffff"];
    }
    return _nameLab;
}


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.frame = CGRectMake(40*WIDTH_SCALE, 880*HEIGHT_SCALE, 100*WIDTH_SCALE, 100*WIDTH_SCALE);
        //[_leftimg sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910365638,1248188591&fm=26&gp=0.jpg"]];
    }
    return _leftimg;
}

-(UIImageView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIImageView alloc] init];
        _rightimg.frame = CGRectMake(kScreenW/2+40*WIDTH_SCALE, 880*HEIGHT_SCALE, 100*WIDTH_SCALE, 100*WIDTH_SCALE);
       // [_rightimg sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910365638,1248188591&fm=26&gp=0.jpg"]];
    }
    return _rightimg;
}

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.frame = CGRectMake(20*WIDTH_SCALE, 990*HEIGHT_SCALE, kScreenW/2-40*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _leftLab.textAlignment = NSTextAlignmentCenter;
        _leftLab.text = @"女娲云婚礼APP下载";
        _leftLab.font = [UIFont systemFontOfSize:13];
        _leftLab.textColor = [UIColor whiteColor];
    }
    return _leftLab;
}

-(UILabel *)rightLab
{
    if(!_rightLab)
    {
        _rightLab = [[UILabel alloc] init];
        _rightLab.frame = CGRectMake(kScreenW/2+20*WIDTH_SCALE, 990*HEIGHT_SCALE, kScreenW/2-40*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _rightLab.textAlignment = NSTextAlignmentCenter;
        _rightLab.text = @"扫码进入婚礼直播";
        _rightLab.font = [UIFont systemFontOfSize:13];
        _rightLab.textColor = [UIColor whiteColor];
    }
    return _rightLab;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 600*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab0.font = [UIFont systemFontOfSize:17];
        _lab0.textAlignment = NSTextAlignmentCenter;
        _lab0.text = @"爱情因神的眷佑而永恒";
        _lab0.textColor = [UIColor whiteColor];
    }
    return _lab0;
}


-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 630*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab1.font = [UIFont systemFontOfSize:17];
        _lab1.textAlignment = NSTextAlignmentCenter;
        _lab1.text = @"爱情因神的眷佑而永恒";
        _lab1.textColor = [UIColor whiteColor];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 660*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab2.font = [UIFont systemFontOfSize:17];
        _lab2.textAlignment = NSTextAlignmentCenter;
        _lab2.textColor = [UIColor whiteColor];
    }
    return _lab2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.font = [UIFont systemFontOfSize:17];
        _lab3.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 690*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab3.textAlignment = NSTextAlignmentCenter;
        _lab3.text = @"诚邀您见证我们的婚礼";
        _lab3.textColor = [UIColor whiteColor];
    }
    return _lab3;
}

-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 720*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab4.font = [UIFont systemFontOfSize:17];
        _lab4.textAlignment = NSTextAlignmentCenter;
        _lab4.text = @"爱情   亲情   友情";
        _lab4.textColor = [UIColor whiteColor];
    }
    return _lab4;
}

-(UILabel *)lab5
{
    if(!_lab5)
    {
        _lab5 = [[UILabel alloc] init];
        _lab5.font = [UIFont systemFontOfSize:17];
        _lab5.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 750*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab5.textAlignment = NSTextAlignmentCenter;
        _lab5.text = @"幸福   欢乐   感动";
        _lab5.textColor = [UIColor whiteColor];
    }
    return _lab5;
}


-(UILabel *)lab6
{
    if(!_lab6)
    {
        _lab6 = [[UILabel alloc] init];
        _lab6.font = [UIFont systemFontOfSize:17];
        _lab6.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 780*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab6.textAlignment = NSTextAlignmentCenter;
        _lab6.text = @"女娲云婚礼   全程直播";
        _lab6.textColor = [UIColor whiteColor];
    }
    return _lab6;
}

-(UILabel *)lab7
{
    if(!_lab7)
    {
        _lab7 = [[UILabel alloc] init];
        _lab7.font = [UIFont systemFontOfSize:17];
        _lab7.frame = CGRectMake(kScreenW/2-100*WIDTH_SCALE, 810*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
        _lab7.textAlignment = NSTextAlignmentCenter;

        _lab7.textColor = [UIColor whiteColor];
    }
    return _lab7;
}






#pragma mark - 实现方法

-(void)rightAction
{
    NSLog(@"rightAction");
    
//    [self screenShot:self.scroll];
}

#pragma mark - 截屏
- (void)screenShot:(UIScrollView *)basetable{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(basetable.contentSize);
    {
        CGPoint savedContentOffset = basetable.contentOffset;
        CGRect savedFrame = basetable.frame;
        basetable.contentOffset = CGPointZero;
        
        basetable.frame = CGRectMake(0, 0, basetable.contentSize.width, basetable.contentSize.height);
        [basetable.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        basetable.contentOffset = savedContentOffset;
        basetable.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    if (image != nil) {
        NSLog(@"截图成功!");
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
        
        NSArray *titlearr = @[@"微信朋友圈",@"微信好友",@"QQ"];
        NSArray *imageArr = @[@"wechatquan",@"wechat",@"tcentQQ"];
        ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享" and:ShowTypeIsShareStyle];
        [actionsheet setBtnClick:^(NSInteger btnTag) {
            NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
            if (btnTag==0) {
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeWechatFriends shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];
            }
            if (btnTag==1) {
                
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                 model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeWechat shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];
                
            }
            if (btnTag==2) {
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                 model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeQQ shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];
            }
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
        
    }
}


#pragma mark - 保存到相册
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if(!error){
        NSLog(@"存到相册");
    }else{
        NSLog(@"存储失败");
        
    }
}


-(void)rightbtn0click
{
    [self screenShot:self.scroll];
}

-(void)fenxiang
{
    NSArray *titlearr = @[@"微信朋友圈",@"微信好友",@"QQ"];
    NSArray *imageArr = @[@"wechatquan",@"wechat",@"tcentQQ"];
    ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"喜帖" and:ShowTypeIsShareStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
        if (btnTag==1) {
            
        }
        if (btnTag==2) {
            
        }
        if (btnTag==3) {
            
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

-(void)rightbtn1click
{
    PreLiveVC *vc = [[PreLiveVC alloc] init];
    vc.istesting = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backAction
{
//    [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
#pragma mark - 将某个时间戳转化成 时间

-(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //format = @"YYYY-MM-dd hh:mm:ss";
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


@end
