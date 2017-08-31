//
//  CustomerserviceVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "CustomerserviceVC.h"

#import "NELivePlayer.h"
#import "NELivePlayerController.h"

@interface CustomerserviceVC ()
@property(nonatomic, strong) id<NELivePlayer> player;
@property (nonatomic,strong) NSURL *url;

@end

@implementation CustomerserviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    // Do any additional setup after loading the view.
    
    self.player = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://hdl.9158.com/live/39c979ddc595d701b626acbc605e0d41.flv"]];
    //self.player.view.frame = self.view.frame;
    self.player.shouldAutoplay = YES;
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];
    
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
