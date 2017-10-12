//
//  WMPlayerVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WMPlayerVC.h"
#import "WMPlayer.h"

@interface WMPlayerVC ()<WMPlayerDelegate>

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) WMPlayer *player;

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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.player resetWMPlayer];
}


- (void)addWMPlayer{
    self.player = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.player.URLString = self.url;
    [self.view addSubview:self.player];
    self.player.delegate = self;
    [self.player play];
}

-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    if (wmplayer.state == WMPlayerStatePlaying) {
        [wmplayer pause];
    } else {
        [wmplayer play];
    }
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
