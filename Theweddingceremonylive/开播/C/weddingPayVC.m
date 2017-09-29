//
//  weddingPayVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingPayVC.h"
#import "perfectinglineVC.h"
#import "zhifuView.h"
#import "AppDelegate.h"

@interface weddingPayVC ()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *labname0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *labname1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *labname2;
@property (nonatomic,strong) UIView *lineview;
@property (strong, nonatomic)UIView *bgView;//半透明背景
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,strong) zhifuView *zhiView;


@end

@implementation weddingPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付";
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.view addSubview:self.bgview];
    [self.view addSubview:self.lab0];
    [self.view addSubview:self.labname0];
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.labname1];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.labname2];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.lineview];
    [self.view addSubview:self.pricelab];
    [self.view addSubview:self.submitBtn];
    
//    [self.view addSubview:self.zhiView];
    [self setuplayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(10*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-10*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(85*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf.view).with.offset(-167*HEIGHT_SCALE);
    }];
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgview.mas_left).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.bgview.mas_top).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.labname0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.bgview.mas_top).with.offset(30*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgview.mas_left).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab0.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.labname1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab1);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgview.mas_left).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab1.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.labname2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab2);
        make.height.mas_offset(18*HEIGHT_SCALE);
    }];
    [weakSelf.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgview.mas_left).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf.bgview.mas_right).with.offset(-15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab2.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.height.mas_offset(1);
    }];
    [weakSelf.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineview);
        make.right.equalTo(weakSelf.lineview);
        make.top.equalTo(weakSelf.lineview.mas_bottom).with.offset(30*HEIGHT_SCALE);
        
    }];
    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineview);
        make.right.equalTo(weakSelf.lineview);
        make.top.equalTo(weakSelf.lab3.mas_bottom).with.offset(30*HEIGHT_SCALE);
    }];
    
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pricelab.mas_bottom).with.offset(35*HEIGHT_SCALE);
        make.width.mas_offset(250*WIDTH_SCALE);
        make.height.mas_offset(50*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(kScreenW/2-125*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor whiteColor];
    }
    return _bgview;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.text = @"房间类型:";
        _lab0.textColor = [UIColor colorWithHexString:@"333333"];
        _lab0.font = [UIFont systemFontOfSize:14];
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.textColor = [UIColor colorWithHexString:@"333333"];
        _lab1.font = [UIFont systemFontOfSize:14];
        _lab1.text = @"一生珍藏:";
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.text = @"推荐之选:";
        _lab2.textColor = [UIColor colorWithHexString:@"333333"];
        _lab2.font = [UIFont systemFontOfSize:14];
    }
    return _lab2;
}


-(UILabel *)labname0
{
    if(!_labname0)
    {
        _labname0 = [[UILabel alloc] init];
        _labname0.textColor = [UIColor colorWithHexString:@"999999"];
        _labname0.font = [UIFont systemFontOfSize:14];
        //_labname0.text = @"公众人物（500人）¥600";
        _labname0.text = self.name0;
    }
    return _labname0;
}

-(UILabel *)labname1
{
    if(!_labname1)
    {
        _labname1 = [[UILabel alloc] init];
        _labname1.textColor = [UIColor colorWithHexString:@"999999"];
        _labname1.text = @"高清版:(¥59)";
        _labname1.text = self.name1;
        _labname1.font = [UIFont systemFontOfSize:14];
    }
    return _labname1;
}

-(UILabel *)labname2
{
    if(!_labname2)
    {
        _labname2 = [[UILabel alloc] init];
        _labname2.font = [UIFont systemFontOfSize:14];
        _labname2.textColor = [UIColor colorWithHexString:@"999999"];
        _labname2.text = @"宣传片:¥5000";
        _labname2.text = self.name2;
    }
    return _labname2;
}

-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"d6d6d6"];
    }
    return _lineview;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.text = @"您需要支付的金额共计";
        _lab3.font = [UIFont systemFontOfSize:17];
        _lab3.textAlignment = NSTextAlignmentCenter;
        _lab3.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lab3;
}

-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.textColor = [UIColor colorWithHexString:@"ed5e40"];
        _pricelab.font = [UIFont systemFontOfSize:16];
        _pricelab.textAlignment = NSTextAlignmentCenter;
        _pricelab.text = [NSString stringWithFormat:@"%@%@%@",@"¥",@" ",self.order_price];
//        _pricelab.text = self.order_price;
    }
    return _pricelab;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_submitBtn setTitle:@"确认支付" forState:normal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(zhifuView *)zhiView
{
    if(!_zhiView)
    {
        _zhiView = [[zhifuView alloc] init];
//        _zhiView.layer.masksToBounds = YES;
//        _zhiView.layer.borderWidth = 1;
        _zhiView.backgroundColor = [UIColor whiteColor];
        _zhiView.frame = CGRectMake(20, -300, kScreenW-40, 150*HEIGHT_SCALE);
        [_zhiView.rightbtn addTarget:self action:@selector(guanbiclick) forControlEvents:UIControlEventTouchUpInside];
        [_zhiView.btn0 addTarget:self action:@selector(weixinclick) forControlEvents:UIControlEventTouchUpInside];
        [_zhiView.btn1 addTarget:self action:@selector(zhifubaoclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhiView;
}

-(void)submitbtnclick
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    _bgView = [[UIView alloc]init];
    _bgView.frame = window.bounds;
    //3. 背景颜色可以用多种方法
    _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    //    _bgView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    [window addSubview:_bgView];

    //6.给背景添加一个手势，后续方便移除视图
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAlertView)];
    [_bgView addGestureRecognizer:tap];
    
    [window addSubview:self.zhiView];
    [UIView animateWithDuration:0.3 animations:^{
        self.zhiView.transform = CGAffineTransformMakeTranslation(0, 500*HEIGHT_SCALE);
        
    }];
    
}

-(void)hideAlertView
{
    [_bgView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.zhiView.transform = CGAffineTransformIdentity;
        
    }];
}

-(void)guanbiclick
{
      [_bgView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.zhiView.transform = CGAffineTransformIdentity;
        
    }];
}

-(void)weixinclick
{
    [_bgView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.zhiView.transform = CGAffineTransformIdentity;
        
    }];
    [MBProgressHUD showSuccess:@"微信支付暂未开通，敬请期待" toView:self.view];
    //[self zhifujiekou];
}

-(void)zhifubaoclick
{
      [_bgView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.zhiView.transform = CGAffineTransformIdentity;
        
    }];
    [self zhifujiekou];
}
//支付接口

-(void)zhifujiekou
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    
    if ([strisNull isNullToString:self.order_goods_tuijian]) {
        self.order_goods_tuijian = @"";
    }
    
    NSDictionary *para = [NSDictionary dictionary];
    
    if ([self.order_pattern isEqualToString:@"1"]) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        [formatter setDateFormat:@"YYYY-MM-dd"];// 此行代码与上面两行作用一样，故上面两行代码失效
        NSDate *date2 = [formatter dateFromString:DateTime];
        NSLog(@"%@", date2);// 这个时间是格林尼治时间
        NSString *dateStrddd = [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
        NSLog(@"%@", dateStrddd);// 这个时间是北京时间戳
        self.create_time = dateStrddd;
        
    }
    
    if ([strisNull isNullToString:self.tuijian]) {
        para = @{@"uid":uid,@"token":token,@"order_pattern":self.order_pattern,@"order_goods":self.order_goods,@"order_goods_tuijian":self.order_goods_tuijian,@"order_price":self.order_price,@"create_time":self.create_time,@"room_count":self.room_count};
    }
    else
    {
        para = @{@"uid":uid,@"token":token,@"order_pattern":self.order_pattern,@"order_goods":self.order_goods,@"order_goods_tuijian":self.order_goods_tuijian,@"order_price":self.order_price,@"tuijian":self.tuijian,@"create_time":self.create_time,@"room_count":self.room_count};
    }
    
    [DNNetworking postWithURLString:post_orderup parameters:para success:^(id obj) {
        NSString *mes = [obj objectForKey:@"msg"];

        [MBProgressHUD showSuccess:mes toView:self.view];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            perfectinglineVC *vc = [[perfectinglineVC alloc] init];
            vc.order_id = [obj objectForKey:@"data"];
            vc.typestr = self.order_pattern;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
    }];
    

}

#pragma mark - tabbar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([strisNull isNullToString:self.order_goods_tuijian]) {
        [self.lab3 setHidden:YES];
        [self.labname2 setHidden:YES];
    }
    
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
@end
