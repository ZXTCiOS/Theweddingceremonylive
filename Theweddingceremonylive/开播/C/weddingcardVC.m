//
//  weddingcardVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "weddingcardVC.h"

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
@end

@implementation weddingcardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xitie_share"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getters

-(UIScrollView *)scroll
{
    if(!_scroll)
    {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scroll.delegate = self;
        _scroll.contentSize = CGSizeMake(kScreenW, 1000*HEIGHT_SCALE);
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
        [_headimg sd_setImageWithURL:[NSURL URLWithString:@"http://img.duote.com/qqTxImg/2011/07/25/13115669302341.jpg"]];
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
        _nameLab.text = @"东东&西西";
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
        [_leftimg sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910365638,1248188591&fm=26&gp=0.jpg"]];
    }
    return _leftimg;
}

-(UIImageView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIImageView alloc] init];
        _rightimg.frame = CGRectMake(kScreenW/2+40*WIDTH_SCALE, 880*HEIGHT_SCALE, 100*WIDTH_SCALE, 100*WIDTH_SCALE);
        [_rightimg sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910365638,1248188591&fm=26&gp=0.jpg"]];
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
        _lab0.text = @"在最美的年华遇到最好的你";
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
        _lab1.text = @"沉浸于幸福中我们将于2018";
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
        _lab2.text = @"时间";
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
        _lab3.text = @"亲友邀请码";
        _lab3.textColor = [UIColor whiteColor];
    }
    return _lab3;
}

-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.font = [UIFont systemFontOfSize:17];
        _lab4.textAlignment = NSTextAlignmentCenter;
    }
    return _lab4;
}

-(UILabel *)lab5
{
    if(!_lab5)
    {
        _lab5 = [[UILabel alloc] init];
        _lab5.font = [UIFont systemFontOfSize:17];
        _lab5.textAlignment = NSTextAlignmentCenter;
    }
    return _lab5;
}







#pragma mark - 实现方法

-(void)rightAction
{
    NSLog(@"rightAction");
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
