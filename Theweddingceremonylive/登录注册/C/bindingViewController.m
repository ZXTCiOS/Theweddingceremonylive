//
//  bindingViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bindingViewController.h"
#import "QCCountdownButton.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface bindingViewController ()<UITextFieldDelegate,YBAttributeTapActionDelegate>
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
@property (nonatomic,strong) UILabel *aggrentlab;
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
    [self.view addSubview:self.aggrentlab];
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
        make.top.equalTo(weakSelf.view).with.offset(10+64);
        make.width.mas_offset(70*WIDTH_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    [self.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right);
        make.top.equalTo(weakSelf.lab0).with.offset(2*HEIGHT_SCALE);
        make.height.mas_offset(38*HEIGHT_SCALE);
        make.width.mas_offset(1);
    }];
    [self.phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0.mas_right);
        make.top.equalTo(weakSelf.lab0);
        make.height.mas_offset(40*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view);
        
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.phonetext.mas_bottom).with.offset(2);
    }];
    
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.lab0.mas_bottom);
        make.width.mas_offset(70*WIDTH_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab1.mas_right);
        make.top.equalTo(weakSelf.lab1).with.offset(2*HEIGHT_SCALE);
        make.height.mas_offset(38*HEIGHT_SCALE);
        make.width.mas_offset(1);
    }];
    [self.validationtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line2.mas_right);
        make.top.equalTo(weakSelf.lab1);
        make.height.mas_offset(40*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        
    }];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.validationtext.mas_bottom).with.offset(2);
    }];
    
    [self.sentCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(260*WIDTH_SCALE);
        make.right.equalTo(weakSelf.validationtext.mas_right);
        make.top.equalTo(weakSelf.validationtext.mas_top).with.offset(8*HEIGHT_SCALE);
        make.height.mas_offset(30*HEIGHT_SCALE);
    }];
    
    [self.aggrentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_offset(20);
        make.bottom.equalTo(weakSelf.view).with.offset(-10);
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
        _lab0.backgroundColor = [UIColor whiteColor];
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
        _lab1.backgroundColor = [UIColor whiteColor];
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
        _phonetext.backgroundColor = [UIColor whiteColor];
    }
    return _phonetext;
}


-(UITextField *)validationtext
{
    if(!_validationtext)
    {
        _validationtext = [[UITextField alloc] init];
        _validationtext.placeholder = @"请输入验证码";
        _validationtext.backgroundColor = [UIColor whiteColor];
    }
    return _validationtext;
}

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
        
    }
    return _line0;
}

-(UIView  *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
        
    }
    return _line1;
}

-(UIView *)line2
{
    if(!_line2)
    {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
    }
    return _line2;
}

-(UIView *)line3
{
    if(!_line3)
    {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
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
        _sentCodeBtn.layer.cornerRadius = 15*HEIGHT_SCALE;
    }
    return _sentCodeBtn;
}

-(UILabel *)aggrentlab
{
    if(!_aggrentlab)
    {
        _aggrentlab = [[UILabel alloc] init];
        NSString *str = @"绑定代表您已同意使用条款与隐私政策";
        _aggrentlab.font = [UIFont systemFontOfSize:12];
        //创建NSMutableAttributedString
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //设置字体和设置字体的范围
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(8
                                                                                                       , 9)];
        //添加文字颜色
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"418ECE"] range:NSMakeRange(8, 9)];
        //添加下划线
        [attrStr addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                        range:NSMakeRange(8, 9)];
        _aggrentlab.textColor = [UIColor colorWithHexString:@"CDCDC7"];
        _aggrentlab.attributedText = attrStr;
        
        [_aggrentlab sizeToFit];
        
        [_aggrentlab yb_addAttributeTapActionWithStrings:@[@"使用条款与隐私政策"] delegate:self];
        
        [_aggrentlab yb_addAttributeTapActionWithStrings:@[@"使用条款与隐私政策"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            NSLog(@"122");
            
        }];
        _aggrentlab.textAlignment = NSTextAlignmentCenter;
    }
    return _aggrentlab;
}


#pragma mark - 实现方法

-(void)submitbtnclick
{
    
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phonetext resignFirstResponder];
    [self.validationtext resignFirstResponder];
}


@end
