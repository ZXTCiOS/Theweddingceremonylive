//
//  CustomerserviceVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "CustomerserviceVC.h"

@interface CustomerserviceVC ()
@property (nonatomic,strong) UIImageView *img;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *phoneBtn;
@end

@implementation CustomerserviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服";
    // Do any additional setup after loading the view.
    

    [self.view addSubview:self.img];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.phoneBtn];
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(kScreenW/2-125/2*WIDTH_SCALE);
        //make.right.equalTo(weakSelf.view).with.offset(-125*WIDTH_SCALE);
        make.width.mas_offset(125*WIDTH_SCALE);
        make.height.mas_offset(125*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(140*HEIGHT_SCALE);
    }];
 
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img.mas_bottom).with.offset(3*HEIGHT_SCALE);
    }];
    
    [weakSelf.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(kScreenW/2-110*WIDTH_SCALE);
        make.width.mas_offset(220*WIDTH_SCALE);
        make.height.mas_offset(50*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.img.mas_bottom).with.offset(80*HEIGHT_SCALE);
    }];
    
    
}

#pragma mark - getters

-(UIImageView *)img
{
    if(!_img)
    {
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"erweima"];
    }
    return _img;
}


-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"公众号:女娲云直播";
        _nameLab.font = [UIFont systemFontOfSize:12];
        _nameLab.textColor = [UIColor colorWithHexString:@"13"];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _nameLab;
}


-(UIButton *)phoneBtn
{
    if(!_phoneBtn)
    {
        _phoneBtn = [[UIButton alloc] init];
        _phoneBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        [_phoneBtn setTitle:@"电话客服" forState:normal];
        _phoneBtn.layer.masksToBounds = YES;
        _phoneBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_phoneBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    }
    return _phoneBtn;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


@end
