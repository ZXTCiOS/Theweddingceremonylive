//
//  WMPlayerVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WMPlayerVC.h"
#import "WMPlayer.h"

@interface WMPlayerVC ()

@property (nonatomic, copy) NSString *url;

@end

@implementation WMPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addWMPlayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)addWMPlayer{
    WMPlayer *player = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    player.URLString = self.url;
    [self.view addSubview:player];
    [player play];
}

#pragma mark - 改变 方向




#pragma mark - init

- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
