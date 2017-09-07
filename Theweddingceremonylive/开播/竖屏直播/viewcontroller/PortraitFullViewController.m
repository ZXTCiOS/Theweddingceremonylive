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


//#define urls @"rtmp://ve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d"// rtmp

#define urls @"http://flve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d.flv?netease=flve266c7be.live.126.net" // HTTP


@interface PortraitFullViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UIScrollView *maskview;// 遮罩层

@property (nonatomic) UIImageView *placeholderView; // 模糊图片

//@property (nonatomic, strong) IJKFFMoviePlayerController *player;
///@property (nonatomic, strong) NELivePlayerController *player;
@property(nonatomic, strong) id<NELivePlayer> liveplayer; // 网易云播放器
@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) PortraitChatView *chatView; // 聊天框

@property (nonatomic, strong) PortraitAudienceView *audienceView; // 观众 view



@end

@implementation PortraitFullViewController






- (void)configPlayer{
    
        
    self.liveplayer = [[NELivePlayerController alloc] initWithContentURL:urls.xd_URL];
    if (self.liveplayer == nil) {
        NSLog(@"failed to initialize!");
    }
    UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.liveplayer.view.frame = playerView.bounds;
    [self.liveplayer prepareToPlay];
    self.liveplayer.shouldAutoplay = YES;
    [self.view addSubview:self.liveplayer.view];
    [self.liveplayer play];
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
    
    [self liveplayer];
    [self placeholderView];
    [self configMaskview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_liveplayer];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.liveplayer setBufferStrategy:NELPLowDelay];
    [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
    [self.liveplayer setShouldAutoplay:YES];
    [self.liveplayer setPauseInBackground:NO];
    [self.liveplayer setPlaybackTimeout:15 *1000];
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
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerDidPreparedToPlayNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerLoadStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackFinishedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstVideoDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstAudioDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerVideoParseErrorNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerMoviePlayerSeekCompletedNotification object:_liveplayer];
}


#pragma mark - lazy loading  懒加载

- (id<NELivePlayer>)liveplayer{
    if (!_liveplayer) {
        _liveplayer = [[NELivePlayerController alloc] initWithContentURL:urls.xd_URL];
        if (!_liveplayer) {
            NSLog(@"播放器初始化失败");
        }
        UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _liveplayer.view.frame = playerView.bounds;
        [_liveplayer prepareToPlay];
        _liveplayer.shouldAutoplay = YES;
        [self.view addSubview:_liveplayer.view];
        [_liveplayer play];
    }
    return _liveplayer;
}

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


- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    //add some methods
    NSLog(@"NELivePlayerDidPreparedToPlay");
    //[self syncUIStatus];
    [self.liveplayer play]; //开始播放
}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification
{
    //    NSLog(@"NELivePlayerPlaybackStateChanged");
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification
{
    NELPMovieLoadState nelpLoadState = _liveplayer.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
//        self.bufferingIndicate.hidden = YES;
//        self.bufferingReminder.hidden = YES;
//        [self.bufferingIndicate stopAnimating];
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
//        self.bufferingIndicate.hidden = NO;
//        self.bufferingReminder.hidden = NO;
//        [self.bufferingIndicate startAnimating];
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification
{
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
//            if ([self.mediaType isEqualToString:@"livestream"]) {
//                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
//                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                    if (self.presentingViewController) {
//                        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//                    }}];
//                [alertController addAction:action];
//                [self presentViewController:alertController animated:YES completion:nil];
            //}
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                if (self.presentingViewController) {
                    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification
{
    NSLog(@"first video frame rendered!");
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification
{
    NSLog(@"first audio frame rendered!");
}

- (void)NELivePlayerVideoParseError:(NSNotification*)notification
{
    NSLog(@"video parse error!");
}

- (void)NELivePlayerSeekComplete:(NSNotification*)notification
{
    NSLog(@"seek complete!");
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification
{
    NSLog(@"resource release success!!!");
    // 释放timer
//    if (timer != nil) {
//        dispatch_source_cancel(timer);
//        timer = nil;
//    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerReleaseSueecssNotification object:_liveplayer];
}



#pragma mark - initialize 初始化

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
