//
//  MiddleVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MiddleVC.h"
#import "midVC.h"
#import "RealVC.h"

@interface MiddleVC ()

@end

@implementation MiddleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"";
    
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    RealVC *vc = [[RealVC alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
