//
//  LiveVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveVC.h"
#import "ViewController.h"
@interface LiveVC ()

@end

@implementation LiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"333333"];
    self.tabBarController.tabBar.alpha = 0.1f;
    //设置为透明
    self.tabBarController.tabBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.alpha = 1;
    //设置为透明
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"ed5e40"];
}



@end
