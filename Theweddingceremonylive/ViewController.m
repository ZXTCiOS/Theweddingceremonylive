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
#import "MineVC.h"

@interface ViewController ()
{
    UIImageView *imageView;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    LiveVC *first = [[LiveVC alloc] init];
    first.tabBarItem.image = [UIImage imageNamed:@"TabBar1"];
    [first.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar1Sel"]];
    
    MainVC *second = [[MainVC alloc] init];
    second.tabBarItem.image = [UIImage imageNamed:@"TabBar2"];
    [second.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar2Sel"]];
    
    
    MiddleVC *middle = [[MiddleVC alloc] init];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"摄影机图标_点击后"] highlightImage:nil];
    
    BBSVC *third = [[BBSVC alloc] init];

    third.tabBarItem.image = [UIImage imageNamed:@"TabBar4"];
    [third.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar4Sel"]];
    
    MineVC *four = [[MineVC alloc] init];
    four.tabBarItem.image = [UIImage imageNamed:@"TabBar5"];
    [four.tabBarItem setSelectedImage:[UIImage imageNamed:@"TabBar5Sel"]];
    
    self.viewControllers = @[first,second,middle,third,four];
    
    if (self.tabBar.selectedItem==0) {
        self.tabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        self.tabBarController.tabBar.shadowImage = [UIImage new];
    }
    else
    {
        self.tabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
        self.tabBarController.tabBar.shadowImage = [UIImage new];
    }
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
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
}

- (void)buttonClick
{
    NSLog(@"点击中间按钮");
    MiddleVC *middle = [[MiddleVC alloc] init];
    [self.navigationController pushViewController:middle animated:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
