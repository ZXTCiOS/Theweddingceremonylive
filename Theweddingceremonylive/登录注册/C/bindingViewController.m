//
//  bindingViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bindingViewController.h"
#import "QCCountdownButton.h"
@interface bindingViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UITextField *phonetext;
@property (nonatomic,strong) UITextField *validationtext;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UIView *line3;
@property (nonatomic,strong) QCCountdownButton *sentCodeBtn;
@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation bindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机号";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    [self.view addSubview:self.lab0];
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.phonetext];
    [self.view addSubview:self.validationtext];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.sentCodeBtn];
    [self.view addSubview:self.submitBtn];
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
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(10);
        make.width.mas_offset(70*WIDTH_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    [self.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right);
        make.top.equalTo(weakSelf.lab0).with.offset(2);
        make.height.mas_offset(38*HEIGHT_SCALE);
        make.width.mas_offset(1);
    }];
    [self.phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark - getters


-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.text = @"手机号";
        _lab0.textAlignment = NSTextAlignmentCenter;
        _lab0.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.text = @"验证码";
        _lab1.textAlignment = NSTextAlignmentCenter;
        _lab1.textColor = [UIColor colorWithHexString:@"999999"];
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
    }
    return _phonetext;
}


-(UITextField *)validationtext
{
    if(!_validationtext)
    {
        _validationtext = [[UITextField alloc] init];
        
    }
    return _validationtext;
}

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];

    }
    return _line0;
}

-(UIView  *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _line1;
}

-(UIView *)line2
{
    if(!_line2)
    {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _line2;
}

-(UIView *)line3
{
    if(!_line3)
    {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor colorWithHexString:@"F3F4F5"];
    }
    return _line3;
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
    }
    return _sentCodeBtn;
}



#pragma mark - 实现方法

-(void)submitbtnclick
{
    
}


#pragma mark -UITextFieldDelegate


@end
