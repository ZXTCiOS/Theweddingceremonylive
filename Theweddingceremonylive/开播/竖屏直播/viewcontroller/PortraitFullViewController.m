//
//  PortraitFullViewController.m
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import "PortraitFullViewController.h"


// model

// view
#import "PortraitFullMaskView.h"
#import "PortraitChatView.h"
#import "PortraitAudienceView.h"

// viewcontroller
#import "NELivePlayerController.h"// 网易云播放器
#import "NELivePlayer.h"// 网易云播放器协议




#define flv @"rtmp://ve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d"


@interface PortraitFullViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UIScrollView *maskview;// 遮罩层

@property (nonatomic) UIImageView *placeholderView; // 模糊图片

//@property (nonatomic, strong) IJKFFMoviePlayerController *player;
///@property (nonatomic, strong) NELivePlayerController *player;
@property(nonatomic, strong) id<NELivePlayer> liveplayer; // 网易云播放器


@property (nonatomic, strong) PortraitChatView *chatView; // 聊天框

@property (nonatomic, strong) PortraitAudienceView *audienceView; // 观众 view



@end

@implementation PortraitFullViewController




- (NSString *)getURL{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     __block NSString *url;
    [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSArray *arr = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
        url = [arr.firstObject objectForKey:@"flv"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    return url;
}

/*
#pragma configPlayer
- (void)configPlayer{
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"" withOptions:[IJKFFOptions optionsByDefault]];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    [self.player prepareToPlay];
    
}
 */

- (void)configPlayer{
    /*
    self.player = [[NELivePlayerController alloc] initWithContentURL:@"http://hdl.9158.com/live/788687910fe9c61a38d7821773c0bb56.flv".xd_URL];
    self.player.view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
    [self.player prepareToPlay];*/
    
    self.liveplayer = [[NELivePlayerController alloc]
                       initWithContentURL:flv.xd_URL];
    if (self.liveplayer == nil) {
        NSLog(@"failed to initialize!");
    }
    
    UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.liveplayer.view.frame = playerView.bounds;
    [self.liveplayer prepareToPlay];
    self.liveplayer.shouldAutoplay = YES;
    [self.view addSubview:self.liveplayer.view];
}



#pragma mark - 设置 view

- (void)configMaskview{
    
    PortraitFullMaskView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PortraitFullMaskView class]) owner:nil options:nil].firstObject;
    view.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
    [view.user_img sd_setImageWithURL:@"http://liveimg.9158.com/pic/avator/2017-08/14/23/20170814230649_63538231_250.png".xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
    view.user_name.text = @"美味🍦静静";
    view.user_id.text = @"id:1231123";
    view.countL.text = @"123321";
    [self configBottomBtn:view];
    view.tableView.tableFooterView = [UIView new];
    view.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    view.tableView.delegate = self;
    view.tableView.dataSource = self;
    //todo: 注册 cell
    
    view.collectionView.delegate = self;
    view.collectionView.dataSource = self;
    //todo: 注册 cell
    
    self.chatView = view.tableView;
    self.audienceView = view.collectionView;
    [self.maskview addSubview:view];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


- (void)configBottomBtn:(PortraitFullMaskView *)view{
    view.first = ^(){//聊天
        NSLog(@"1");
    };
    view.second = ^(){//连麦
        NSLog(@"2");
    };
    view.third = ^(){//礼物
        NSLog(@"3");
    };
    view.fourth = ^(){//红包
        NSLog(@"4");
    };
    view.fifth = ^(){//返回
        [self.navigationController popViewControllerAnimated:YES];
    };
    view.icon = ^(){//个人资料
        
        
    };
}



#pragma mark - chatView(tableView)  delegate  &&  datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark - audience(collectionView)  delegate  &&  datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - life cycle  生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configPlayer];
    [self placeholderView];
    [self configMaskview];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.liveplayer prepareToPlay];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.liveplayer shutdown];
    
}

- (void)dealloc{
    
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    NSLog(@"protraitFullViewController dealloc");
}


#pragma mark - lazy loading  懒加载


- (UIScrollView *)maskview{
    if (!_maskview) {
        _maskview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _maskview.contentSize = CGSizeMake(kScreenW*2, kScreenH);
        _maskview.contentOffset = CGPointMake(kScreenW, 0);
        _maskview.pagingEnabled = YES;
        _maskview.showsVerticalScrollIndicator = NO;
        _maskview.showsHorizontalScrollIndicator = NO;
        _maskview.bounces = NO;
        [self.view addSubview:_maskview];
    }
    return _maskview;
}

- (UIImageView *)placeholderView {
    if(_placeholderView == nil) {
        _placeholderView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        //[_placeholderView setImageURL:@"".xd_URL];
        _placeholderView.image = [UIImage imageNamed:@"qidong"];
        _placeholderView.contentMode = UIViewContentModeScaleAspectFill;
        _placeholderView.clipsToBounds = YES;
        //模糊效果
        UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:blur];
        view.frame = _placeholderView.bounds;
        [_placeholderView addSubview:view];
        [self.view addSubview:_placeholderView];
        [self.view sendSubviewToBack:_placeholderView];
    }
    return _placeholderView;
}


#pragma mark - initialize 初始化




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
