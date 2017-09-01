//
//  pilotliveVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "pilotliveVC.h"

@interface pilotliveVC ()

@end

@implementation pilotliveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

@end
