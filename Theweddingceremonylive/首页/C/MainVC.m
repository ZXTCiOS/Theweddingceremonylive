//
//  MainVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"首页";
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"ed5e40"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
