//
//  midVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "midVC.h"

@interface midVC ()

@end

@implementation midVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视频";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 实现方法

-(void)backAction
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

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
