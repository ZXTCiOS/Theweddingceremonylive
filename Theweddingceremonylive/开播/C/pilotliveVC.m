//
//  pilotliveVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "pilotliveVC.h"
#import "WJGtextView.h"
#import <AVFoundation/AVFoundation.h>

#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>



@interface pilotliveVC ()<NIMNetCallManager>



@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UIButton *btn0;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) WJGtextView *titletext;



@end

@implementation pilotliveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self.view addSubview:self.bgimg];
    
    
    


    [self.view addSubview:self.btn0];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    [self setuplayout];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(15*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-15*WIDTH_SCALE);
        make.width.mas_offset(40*WIDTH_SCALE);
        make.height.mas_offset(40*WIDTH_SCALE);
    }];
    [weakSelf.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn0);
        make.right.equalTo(weakSelf.btn0.mas_left).with.offset(-20*WIDTH_SCALE);
        make.width.mas_offset(40*WIDTH_SCALE);
        make.height.mas_offset(40*WIDTH_SCALE);
    }];
    [weakSelf.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn0);
        make.right.equalTo(weakSelf.btn1.mas_left).with.offset(-20*WIDTH_SCALE);
        make.width.mas_offset(40*WIDTH_SCALE);
        make.height.mas_offset(40*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgimg.image = [UIImage imageNamed:@"zb_tiyan_bg"];
    }
    return _bgimg;
}

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        [_btn0 setImage:[UIImage imageNamed:@"zb_tiyan_close"] forState:normal];
        [_btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setImage:[UIImage imageNamed:@"zb_tiyan_qiehuan"] forState:normal];
        [_btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setImage:[UIImage imageNamed:@"zb_tiyan_xj"] forState:normal];
        [_btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

#pragma mark - 实现方法

-(void)btn0click
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btn1click
{
    
}

-(void)btn2click
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
