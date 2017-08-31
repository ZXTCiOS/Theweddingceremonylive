//
//  CustomerserviceVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "CustomerserviceVC.h"

@interface CustomerserviceVC ()



@end

@implementation CustomerserviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    // Do any additional setup after loading the view.
    

    
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


@end
