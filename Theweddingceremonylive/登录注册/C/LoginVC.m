//
//  LoginVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LoginVC.h"
#import "bottomlineView.h"
#import "FSCustomButton.h"
#import "logupViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "forgetViewController.h"
#import "bindingViewController.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import "ZTVendorManager.h"

#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import <TencentOpenAPI/QQApiInterface.h>

@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *logoimg;
@property (nonatomic,strong) UITextField *nicknametext;
@property (nonatomic,strong) UITextField *passwordtext;
@property (nonatomic,strong) UIButton *loginbtn;

@property (nonatomic,strong) UIView *lineview0;
@property (nonatomic,strong) UIView *lineview1;

@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) UIButton *logupBtn;
@property (nonatomic,strong) bottomlineView *lineV;

@property (nonatomic,strong) FSCustomButton *qqBtn;
@property (nonatomic,strong) FSCustomButton *weixinBtn;

@property (nonatomic, strong) ZTVendorPayManager *payManager;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.logoimg];
    [self.view addSubview:self.nicknametext];
    [self.view addSubview:self.passwordtext];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.lineview0];
    [self.view addSubview:self.lineview1];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.logupBtn];
    [self.view addSubview:self.lineV];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.weixinBtn];
    
    self.payManager = [[ZTVendorPayManager alloc]init];
    [self setuplayout];
    [self weixinLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.logoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(120*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-120*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(60*HEIGHT_SCALE);
        make.height.mas_offset(110*HEIGHT_SCALE);
    }];
    [self.nicknametext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(60*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-60*WIDTH_SCALE);
        make.top.equalTo(weakSelf.logoimg.mas_bottom).with.offset(40*HEIGHT_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    [self.lineview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nicknametext);
        make.right.equalTo(weakSelf.nicknametext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.nicknametext.mas_bottom).with.offset(1);
    }];
    [self.passwordtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(60*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-60*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nicknametext.mas_bottom).with.offset(40*HEIGHT_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    [self.lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordtext);
        make.right.equalTo(weakSelf.passwordtext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passwordtext.mas_bottom).with.offset(1);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineview1);
        make.width.mas_offset(60*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.lineview1.mas_bottom).with.offset(12*HEIGHT_SCALE);
    }];
    
    [self.logupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.forgetBtn);
        make.right.equalTo(weakSelf.lineview1);
        make.width.mas_offset(60*WIDTH_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [self.loginbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.forgetBtn.mas_bottom).with.offset(60*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(60*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-60*WIDTH_SCALE);
        make.height.mas_offset(50*HEIGHT_SCALE);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginbtn.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(60*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-60*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineV.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.lineV).with.offset(60*WIDTH_SCALE);
        make.width.mas_offset(36*WIDTH_SCALE);
        make.height.mas_offset(50*WIDTH_SCALE);
    }];
    
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineV.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.lineV).with.offset(-60*WIDTH_SCALE);
        make.width.mas_offset(36*WIDTH_SCALE);
        make.height.mas_offset(50*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters

-(UIImageView *)logoimg
{
    if(!_logoimg)
    {
        _logoimg = [[UIImageView alloc] init];
        _logoimg.image = [UIImage imageNamed:@"loginlogo"];
    }
    return _logoimg;
}


-(UITextField *)nicknametext
{
    if(!_nicknametext)
    {
        _nicknametext = [[UITextField alloc] init];
        _nicknametext.delegate = self;
        _nicknametext.placeholder = @"手机号";
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 32)];
        imageViewPwd.image=[UIImage imageNamed:@"iphone-1"];
        _nicknametext.leftView=imageViewPwd;
        _nicknametext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _nicknametext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UILabel * placeholderLabel = [_nicknametext valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _nicknametext.keyboardType = UIKeyboardTypePhonePad;
    }
    return _nicknametext;
}

-(UITextField *)passwordtext
{
    if(!_passwordtext)
    {
        _passwordtext = [[UITextField alloc] init];
        _passwordtext.delegate = self;
        _passwordtext.placeholder = @"密码";
        UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
        imageViewPwd.image=[UIImage imageNamed:@"password"];
        _passwordtext.leftView=imageViewPwd;
        _passwordtext.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordtext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UILabel * placeholderLabel = [_passwordtext valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _passwordtext.secureTextEntry = YES;
    }
    return _passwordtext;
}

-(UIView *)lineview0
{
    if(!_lineview0)
    {
        _lineview0 = [[UIView alloc] init];
        _lineview0.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _lineview0;
}

-(UIView *)lineview1
{
    if(!_lineview1)
    {
        _lineview1 = [[UIView alloc] init];
        _lineview1.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _lineview1;
}

-(UIButton *)forgetBtn
{
    if(!_forgetBtn)
    {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"E95F46"] forState:normal];
        [_forgetBtn setTitle:@"忘记密码" forState:normal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _forgetBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_forgetBtn addTarget:self action:@selector(forgetbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

-(UIButton *)logupBtn
{
    if(!_logupBtn)
    {
        _logupBtn = [[UIButton alloc] init];
        [_logupBtn setTitle:@"注册" forState:normal];
        [_logupBtn setTitleColor:[UIColor colorWithHexString:@"E95F46"] forState:normal];
        _logupBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_logupBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_logupBtn addTarget:self action:@selector(logupbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logupBtn;
}


-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        _loginbtn.backgroundColor = [UIColor colorWithHexString:@"E95F46"];
        [_loginbtn setTitle:@"登录" forState:normal];
        [_loginbtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_loginbtn addTarget:self action:@selector(loginbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _loginbtn.layer.masksToBounds = YES;
        _loginbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _loginbtn;
}


-(bottomlineView *)lineV
{
    if(!_lineV)
    {
        _lineV = [[bottomlineView alloc] init];
        
    }
    return _lineV;
}


-(FSCustomButton *)qqBtn
{
    if(!_qqBtn)
    {
        _qqBtn = [[FSCustomButton alloc] init];
        [_qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_qqBtn setTitle:@"QQ" forState:normal];
        _qqBtn.adjustsTitleTintColorAutomatically = YES;
        [_qqBtn setTitleColor:[UIColor colorWithHexString:@"c7c7cd"] forState:normal];
        _qqBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _qqBtn.titleEdgeInsets = UIEdgeInsetsMake(8*HEIGHT_SCALE, 0, 0, 0);
        _qqBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_qqBtn addTarget:self action:@selector(qqbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

-(FSCustomButton *)weixinBtn
{
    if(!_weixinBtn)
    {
        _weixinBtn = [[FSCustomButton alloc] init];
        _weixinBtn.adjustsTitleTintColorAutomatically = YES;
        [_weixinBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [_weixinBtn setTitle:@"微信" forState:normal];
        _weixinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_weixinBtn setTitleColor:[UIColor colorWithHexString:@"c7c7cd"] forState:normal];
        _weixinBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _weixinBtn.titleEdgeInsets = UIEdgeInsetsMake(8*HEIGHT_SCALE, 0, 0, 0);
        [_weixinBtn addTarget:self action:@selector(weixinbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinBtn;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nicknametext resignFirstResponder];
    [self.passwordtext resignFirstResponder];
}

#pragma mark - 实现方法

-(void)logupbtnclick
{
    logupViewController *logupvc = [[logupViewController alloc] init];
    [self.navigationController pushViewController:logupvc animated:YES];
}

-(void)forgetbtnclick
{
    forgetViewController *forgetvc = [[forgetViewController alloc] init];
    [self.navigationController pushViewController:forgetvc animated:YES];
}

-(void)loginbtnclick
{
    
    NSString *user_tel = @"";
    NSString *user_pwd = @"";
    if (self.nicknametext.text.length==0) {
        user_tel = @"";
    }
    else
    {
        user_tel = self.nicknametext.text;
    }
    
    if (self.passwordtext.text.length==0) {
        user_pwd = @"";
    }
    else
    {
        user_pwd = self.passwordtext.text;
    }
    
    
    NSString *type = @"1";
    NSDictionary *para = @{@"user_tel":user_tel,@"user_pwd":user_pwd,@"type":type};
    [DNNetworking postWithURLString:post_login parameters:para success:^(id obj) {
        
        //切换根视图控制器
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *tokenstr = [dic objectForKey:@"token"];
            NSString *uidstr = [dic objectForKey:@"uid"];
            NSString *imtoken = [dic objectForKey:@"imtoken"];
            NSString *acount = [dic objectForKey:@"tel"];
            NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
            [defat setObject:tokenstr forKey:user_token];
            [defat setObject:uidstr forKey:user_uid];
            [defat setObject:acount forKey:user_phone];
            [defat setObject:imtoken forKey:user_imtoken];
            [defat synchronize];
            //todo: account...
            
            [self loginNIMWithaccount:acount token:imtoken];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainTabBarController * main = [[MainTabBarController alloc] init];
            appDelegate.window.rootViewController = main;
            
        }
        else
        {
            [MBProgressHUD showSuccess:@"密码错误"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误"];
    }];
    
}

- (void)loginNIMWithaccount:(NSString *)account token:(NSString *)token{
    [[NIMSDK sharedSDK].loginManager login:account token:token completion:^(NSError * _Nullable error) {
        NSLog(@"account: %@, token  :%@, login error %@", account, token, error);
        if (!error) NSLog(@"NIM login sucess");
    }];
}


-(void)qqbtnclick
{
    
    [ZTVendorManager loginWith:ZTVendorPlatformTypeQQ completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
//    bindingViewController *bindingvc = [[bindingViewController alloc] init];
//    [self.navigationController pushViewController:bindingvc animated:YES];
}

-(void)weixinbtnclick
{
    [ZTVendorManager loginWith:ZTVendorPlatformTypeWechat completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
    
//    ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
//    [ZTVendorManager shareWith:ZTVendorPlatformTypeWechat shareModel:model completionHandler:^(BOOL success, NSError * error) {
//        
//    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)weixinLogin{
    if([WXApi isWXAppInstalled]){
        
        [self.weixinBtn setHidden:NO];
        
    }else{
        [self.weixinBtn setHidden:YES];
    }
    if ([QQApiInterface isQQInstalled]) {
        [self.qqBtn setHidden:NO];
    }
    else
    {
        [self.qqBtn setHidden:YES];
    }
    
    
}
#pragma mark - nav

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
@end
