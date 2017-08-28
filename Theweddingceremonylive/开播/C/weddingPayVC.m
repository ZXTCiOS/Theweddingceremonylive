//
//  weddingPayVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingPayVC.h"

@interface weddingPayVC ()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *typelab;

@end

@implementation weddingPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付";
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.view addSubview:self.bgview];
    
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
