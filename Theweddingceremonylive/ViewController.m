//
//  ViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ViewController.h"
#import "LiveVC.h"
#import "MainVC.h"
#import "MiddleVC.h"
#import "BBSVC.h"
#import "MineTVC.h"

@interface ViewController ()<UITabBarControllerDelegate>
{
    UIImageView *imageView;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.delegate = self;
    
    LiveVC *first = [[LiveVC alloc] init];
    first.tabBarItem.image = [UIImage imageNamed:@"TabBar1"];
    [first.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar1Sel"]];
    first.tabBarItem.tag=1;
    
    MainVC *second = [[MainVC alloc] init];
    second.tabBarItem.image = [UIImage imageNamed:@"TabBar2"];
    [second.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar2Sel"]];
    second.tabBarItem.tag=2;
    
    MiddleVC *middle = [[MiddleVC alloc] init];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"摄影机图标_点击前"] highlightImage:[UIImage imageNamed:@""] ];
    middle.tabBarItem.tag = 10;
    
    BBSVC *third = [[BBSVC alloc] init];
    third.tabBarItem.image = [UIImage imageNamed:@"TabBar4"];
    [third.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar4Sel"]];
    third.tabBarItem.tag = 3;
    
    MineTVC *four = [[MineTVC alloc] init];
    four.tabBarItem.image = [UIImage imageNamed:@"TabBar5"];
    [four.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar5Sel"]];
    four.tabBarItem.tag = 4;
    
    
    self.viewControllers = @[first,second,middle,third,four];
    self.selectedViewController = [self.viewControllers objectAtIndex:0];

}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//添加中间按钮
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    self.midBtn = [UIButton new];
    self.midBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    self.midBtn.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [self.midBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.midBtn setBackgroundImage:buttonImage forState:normal];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        self.midBtn.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        self.midBtn.center = center;
    }
    
    [self.view addSubview:self.midBtn];
}

- (void)buttonClick
{
    NSLog(@"点击中间按钮");
    MiddleVC *middle = [[MiddleVC alloc] init];
    [self.navigationController pushViewController:middle animated:YES];
    

}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag==1) {
        [self.midBtn setBackgroundImage:[UIImage imageNamed:@"摄影机图标_点击前"] forState:normal];
    }
    if (item.tag==10) {
        
    }
    else
    {
         [self.midBtn setBackgroundImage:[UIImage imageNamed:@"摄影机图标_点击后"] forState:normal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
