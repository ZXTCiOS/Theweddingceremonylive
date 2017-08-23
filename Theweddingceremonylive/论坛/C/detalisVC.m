//
//  detalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisVC.h"

@interface detalisVC ()

@end

@implementation detalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
