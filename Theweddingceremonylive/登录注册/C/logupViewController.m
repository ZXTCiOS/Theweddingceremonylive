//
//  logupViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupViewController.h"
#import "QCCountdownButton.h"
#import "perfectingViewController.h"

@interface logupViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;

@property (nonatomic,strong) UITextField *phonetext;
@property (nonatomic,strong) UITextField *codetext;
@property (nonatomic,strong) UITextField *passtext;
@property (nonatomic,strong) UITextField *newpasstext;

@property (nonatomic,strong) UIView *lineview0;
@property (nonatomic,strong) UIView *lineview1;
@property (nonatomic,strong) UIView *lineview2;
@property (nonatomic,strong) UIView *lineview3;

@property (nonatomic,strong) QCCountdownButton *sentCodeBtn;
@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,strong) NSString *codestr;
@end

@implementation logupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    [self.view addSubview:self.lab0];
    [self.view addSubview:self.phonetext];
    [self.view addSubview:self.lineview0];
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.codetext];
    [self.view addSubview:self.lineview1];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.sentCodeBtn];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.passtext];
    [self.view addSubview:self.lineview2];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.newpasstext];
    [self.view addSubview:self.lineview3];
    [self setuplayout];
    
    //进度b
    [self.sentCodeBtn processBlock:^(NSUInteger second) {
        self.sentCodeBtn.title = [NSString stringWithFormat:@"(%lis)后重新获取", second] ;
        
      
        
    } onFinishedBlock:^{  // 倒计时完毕
        self.sentCodeBtn.title = @"重新获取验证码";
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(70*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    [self.phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab0.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [self.lineview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phonetext);
        make.right.equalTo(weakSelf.phonetext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.phonetext.mas_bottom).with.offset(1);
    }];
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lineview0).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.codetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phonetext);
        make.right.equalTo(weakSelf.phonetext);
        make.top.equalTo(weakSelf.lab1.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    
    [self.lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.codetext);
        make.right.equalTo(weakSelf.codetext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.codetext.mas_bottom).with.offset(1);
    }];
    
    [self.sentCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(260*WIDTH_SCALE);
        make.right.equalTo(weakSelf.codetext.mas_right);
        make.top.equalTo(weakSelf.codetext.mas_top);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lineview1).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.passtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab2.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [self.lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phonetext);
        make.right.equalTo(weakSelf.phonetext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.passtext.mas_bottom).with.offset(1);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lineview2).with.offset(10*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.newpasstext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.lab3.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [self.lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phonetext);
        make.right.equalTo(weakSelf.phonetext);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.newpasstext.mas_bottom).with.offset(1);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineview3.mas_bottom).with.offset(60*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(60*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-60*WIDTH_SCALE);
        make.height.mas_offset(50*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.font = [UIFont systemFontOfSize:14];
        _lab0.text = @"手机号";
        _lab0.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.font = [UIFont systemFontOfSize:14];
        _lab1.text = @"验证码";
        _lab1.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lab1;
}

-(UITextField *)phonetext
{
    if(!_phonetext)
    {
        _phonetext = [[UITextField alloc] init];
        _phonetext.delegate = self;
        _phonetext.placeholder = @"请输入手机号";
        _phonetext.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phonetext;
}


-(UITextField *)codetext
{
    if(!_codetext)
    {
        _codetext = [[UITextField alloc] init];
        _codetext.delegate = self;
        _codetext.placeholder = @"请输入验证码";
        _codetext.keyboardType = UIKeyboardTypePhonePad;
    }
    return _codetext;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"完成" forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"E95F46"];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _submitBtn;
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

- (QCCountdownButton *)sentCodeBtn{
    if(_sentCodeBtn == nil){
        _sentCodeBtn = [[QCCountdownButton alloc]init];
        [_sentCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        // 字体
        _sentCodeBtn.titleLabelFont = [UIFont systemFontOfSize:13];
        // 普通状态下的背景颜色
        _sentCodeBtn.nomalBackgroundColor = [UIColor colorWithHexString:@"E95F46"];
        // 失效状态下的背景颜色
        _sentCodeBtn.disabledBackgroundColor = [UIColor grayColor];
        // 倒计时的时长
        _sentCodeBtn.totalSecond = KTime;
        _sentCodeBtn.layer.masksToBounds = YES;
        _sentCodeBtn.layer.cornerRadius = 20*HEIGHT_SCALE;
        [_sentCodeBtn addTarget:self action:@selector(sendcodebtnclock) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sentCodeBtn;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.font = [UIFont systemFontOfSize:14];
        _lab2.text = @"密码";
        _lab2.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lab2;
}

-(UITextField *)passtext
{
    if(!_passtext)
    {
        _passtext = [[UITextField alloc] init];
        _passtext.delegate = self;
        _passtext.placeholder = @"6-12位字母或数字，不区分大小写";
        _passtext.secureTextEntry = YES;
    }
    return _passtext;
}

-(UIView *)lineview2
{
    if(!_lineview2)
    {
        _lineview2 = [[UIView alloc] init];
        _lineview2.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _lineview2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.font = [UIFont systemFontOfSize:14];
        _lab3.text = @"确认密码";
        _lab3.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lab3;
}

-(UITextField *)newpasstext
{
    if(!_newpasstext)
    {
        _newpasstext = [[UITextField alloc] init];
        _newpasstext.delegate = self;
        _newpasstext.placeholder = @"6-12位字母或数字，不区分大小写";
        _newpasstext.secureTextEntry = YES;
    }
    return _newpasstext;
}

-(UIView *)lineview3
{
    if(!_lineview3)
    {
        _lineview3 = [[UIView alloc] init];
        _lineview3.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _lineview3;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    if ([self.codestr isEqualToString:self.codetext.text]) {
        if (self.passtext.text!=self.newpasstext.text) {
            [MBProgressHUD showSuccess:@"请检查密码输入"];
        }
        else
        {
            NSString *tel = self.phonetext.text;
            NSString *pwd = self.passtext.text;
            if (self.phonetext.text.length==0) {
                tel = @"";
            }
            else
            {
                tel = self.phonetext.text;
            }
            if (self.passtext.text.length==0) {
                pwd = @"";
            }
            else
            {
                pwd = self.passtext.text;
            }
            
            NSDictionary *para = @{@"tel":tel,@"pwd":pwd};
            [DNNetworking postWithURLString:post_logup parameters:para success:^(id obj) {
                NSString *msg = [obj objectForKey:@"msg"];
                if ([[obj objectForKey:@"code"] intValue]==1000) {
                    [MBProgressHUD showSuccess:msg];
                    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
                    NSDictionary *dic = [obj objectForKey:@"data"];
                    NSString *uid = [dic objectForKey:@"uid"];
                    [defat setObject:uid forKey:user_uid];
                    [defat synchronize];
                    
                    perfectingViewController *pervc = [[perfectingViewController alloc] init];
                    [self.navigationController pushViewController:pervc animated:YES];
                }
                else
                {
                    [MBProgressHUD showSuccess:msg];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
    else
    {
        [MBProgressHUD showSuccess:@"请输入正确的验证码"];
    }
}

-(void)sendcodebtnclock
{
    //验证码
    NSDictionary *para = @{@"phone":self.phonetext.text};
    [DNNetworking postWithURLString:post_value parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"]isEqualToString:@"code"]) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.codestr = [dic objectForKey:@"code"];
            [MBProgressHUD showSuccess:@"请求成功"];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - deletage

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phonetext resignFirstResponder];
    [self.codetext resignFirstResponder];
    [self.passtext resignFirstResponder];
    [self.newpasstext resignFirstResponder];
}


@end
