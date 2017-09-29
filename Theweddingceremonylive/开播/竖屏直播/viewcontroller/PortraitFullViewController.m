//
//  PortraitFullViewController.m
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import "PortraitFullViewController.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import <IQKeyboardManager.h>
#import "NSDictionary+NTESJson.h"
#import "NSString+NTES.h"
#import "GiftAnimation.h"

// model

// view
#import "PortraitFullMaskView.h"
#import "AudienceCell.h"
#import "DanmuCell.h"
#import "GiftView.h"
#import "SendRedBagView.h"
#import "qiangRedbagView.h"
#import "RedbagDetailListView.h"

// viewcontroller
#import "NELivePlayerController.h"// 网易云播放器
#import "NELivePlayer.h"// 网易云播放器协议
#import "rechargeVC.h"

#define urls @"rtmp://ve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d" // rtmp


#define cellID_text @"text"
#define cellID_audience @"audience"

@interface PortraitFullViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, NIMChatroomManagerDelegate, NIMChatManagerDelegate, NIMNetCallManagerDelegate, NIMSystemNotificationManagerDelegate>


@property (nonatomic, strong) UIScrollView *scrollV;                // 遮罩层
@property (nonatomic, strong) PortraitFullMaskView *maskview;
@property (nonatomic) UIImageView *placeholderView;                 // 模糊图片
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) GiftView *giftV;
@property (nonatomic, strong) SendRedBagView *redBag;
@property (nonatomic, strong) qiangRedbagView *qiangRedbag;
@property (nonatomic, strong) RedbagDetailListView *redbaglistV;


@property(nonatomic, strong) id<NELivePlayer> liveplayer;           // 网易云播放器
@property (nonatomic, assign) NIMNetCallCamera camera;
@property (nonatomic, strong) NIMNetCallMeeting *meeting;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *accid;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) weddingType weddingtype;
@property (nonatomic, strong) NSString *yue;

@property (nonatomic, strong) UITableView *tableView;               // 聊天框
@property (nonatomic, strong) UICollectionView *collectionView;     // 观众 view

@property (nonatomic, strong) NSMutableArray<NIMChatroomMember *> *audiencelist;
@property (nonatomic, strong) NSMutableArray<NIMMessage *> *danmulist;
@property (nonatomic, strong) NSMutableArray<NIMChatroomMember *> *managerlist;
@property (nonatomic, strong) NSMutableArray *giftlist;



@end

@implementation PortraitFullViewController

#pragma mark - life cycle  生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.roomid = @"11255726";
    //self.roomName = @"xixi";
    self.meeting = [[NIMNetCallMeeting alloc] init];
    self.meeting.name = self.zhubo_uid;
    self.accid = [userDefault objectForKey:user_nickname];
    self.nickName = [userDefault objectForKey:user_kname];
    
    
    
    
    [self setup];
    [self maskview];
    [self liveplayer];
    [self placeholderView];
    [self addNotification];
    [self enterChatroom];
    [self chatroomManager];
    [self audienceListPerMin];
}

- (void)setup{
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager addDelegate:self];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    //关闭键盘相应
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowshow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidehide:) name: UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.view removeAllSubviews];
    
    
    
    [self.liveplayer shutdown];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [self.timer invalidate];
    self.timer = nil;
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    NSLog(@"protraitFullViewController dealloc");
    // 退出聊天室
    [[NIMSDK sharedSDK].chatroomManager exitChatroom:self.roomid completion:^(NSError * _Nullable error) {
        NSLog(@"退出聊天室 error %@", error);
    }];
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerDidPreparedToPlayNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerLoadStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackFinishedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstVideoDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerFirstAudioDisplayedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerVideoParseErrorNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerPlaybackStateChangedNotification object:_liveplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerMoviePlayerSeekCompletedNotification object:_liveplayer];
    
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager removeDelegate:self];
    
}

- (void)dealloc{
    
    
}



#pragma mark - 分享
- (void)shareBtnClick{
    // TODO: 添加分享功能
    [self.maskview.QQ bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.Wechat bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.Pengyouquan bk_addEventHandler:^(id sender) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 注册 cell
- (void)registerCell{
    // todo: 注册 cell
    [self.tableView registerClass:[DanmuCell class] forCellReuseIdentifier:cellID_text];
    [self.collectionView registerClass:[AudienceCell class] forCellWithReuseIdentifier:cellID_audience];
}

- (void)configBottomBtn:(PortraitFullMaskView *)view{
    view.first = ^(){//聊天
        [self.maskview.textField becomeFirstResponder];
    };
    view.second = ^(){// 红包
        
        self.redBag.hidden = NO;
        
    };
    view.third = ^(){//礼物
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.giftV.frame = CGRectMake(0, kScreenH- 230, kScreenW, 230);
        } completion:nil];
    };
    view.fourth = ^(){//分享
        [UIView animateWithDuration:0.25 animations:^{
            self.maskview.shareView.frame = CGRectMake(0, kScreenH - 110, kScreenW, 110);
            [self.maskview layoutIfNeeded];
        }];
    };
    view.fifth = ^(){//返回
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.maskview.send bk_addEventHandler:^(id sender) {
        // 发送文字消息
        NSString *text = self.maskview.textField.text;
        if (!text.length) return;
        NIMMessage *msg = [[NIMMessage alloc] init];
        msg.text = text;
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:nil];
        if (self.danmulist.count > 50){
            [self.danmulist removeFirstObject];
        }
        [self.danmulist addObject:msg];
        [self.tableView reloadData];
        if (self.danmulist.count > 5) [self.tableView scrollToBottom];
        self.maskview.textField.text = @"";
        [self.maskview.textField resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    view.icon = ^(){//个人资料
        // todo: 查看个人资料
        
    };
    [view.leaveMeeting bk_addEventHandler:^(UIButton *sender) {
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定断开连麦?" preferredStyle:1];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 连麦者主动离开直播间
            [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
            [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
            [self.displayView removeFromSuperview];
            self.displayView = nil;
            [self liveplayer];
            sender.hidden = YES;
        }];
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [vc addAction:act1];
        [vc addAction:act2];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 收到连麦消息  点击同意
- (void)joinLianmai{
    // 打开摄像头
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    [self joinMeeting];
}

// 加入互动直播间
- (void)joinMeeting{
    
    // todo: 修改 option
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    self.meeting.option = option;
    option.enableBypassStreaming = YES;
    self.meeting.actor = YES;
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        [[NIMAVChatSDK sharedSDK].netCallManager setSpeaker:YES];
        NSLog(@"join error %@", error);
        if (!error) NSLog(@"-------加入 metting 成功------  meeting: %@", meeting);
    }];
    self.maskview.leaveMeeting.hidden = NO;
}

// 配置视频采集参数
- (NIMNetCallVideoCaptureParam *)para{
    NIMNetCallVideoCaptureParam *para = [[NIMNetCallVideoCaptureParam alloc] init];
    para.format = 0;
    //默认是否是后置摄像头
    para.startWithBackCamera = YES;
    self.camera = NIMNetCallCameraBack;
    para.startWithCameraOn = YES;
    para.videoCaptureOrientation = 0;
    
    return para;
}

- (void)onLocalDisplayviewReady:(UIView *)displayView{
    // 移除直播拉流播放器
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    if (self.displayView) {
        [self.displayView removeFromSuperview];
    }
    self.displayView = displayView;
    self.displayView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [self.view insertSubview:self.displayView belowSubview:self.scrollV];
    // 默认美颜自然模式
    [[NIMAVChatSDK sharedSDK].netCallManager selectBeautifyType:NIMNetCallFilterTypeZiran];
}

// 用户加入房间通知
- (void)onUserJoined:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    
    
    
}

// 用户离开房间通知
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    }

// 房间错误通知
- (void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting{
    // 一些异常情况可能会引起房间出错，请在收到该回调以后主动离开房间。
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:meeting];
}

// 直播状态回调
- (void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code{
    
}

// 远程视频 YUV 数据就绪
- (void)onRemoteYUVReady:(NSData *)yuvData width:(NSUInteger)width height:(NSUInteger)height from:(NSString *)user{
    
}

- (void)onRemoteImageReady:(CGImageRef)image{
    
}


#pragma mark - 键盘弹出隐藏通知
- (void)keyboardWillShowshow:(NSNotification *) noti{
    
    NSDictionary *userInfo = [noti userInfo];
    //NSLog(@"userinfo: %@", userInfo);
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect frame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frame];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [self.view layoutIfNeeded];
        self.maskview.textFView.frame = CGRectMake(0, frame.origin.y - 40, kScreenW, 40);
        
    }];
}

- (void)keyboardWillHidehide:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    //NSLog(@"userinfo: %@", userInfo);
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.maskview.textFView.frame = CGRectMake(0, kScreenH, kScreenW, 40);
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - 获取观众列表

- (void)chatroomManager{
    // 获取管理员
    NIMChatroomMemberRequest *request = [[NIMChatroomMemberRequest alloc] init];
    request.roomId = self.roomid;
    request.type = NIMChatroomFetchMemberTypeRegular; //  创建者, 管理员...
    [[NIMSDK sharedSDK].chatroomManager fetchChatroomMembers:request completion:^(NSError * _Nullable error, NSArray<NIMChatroomMember *> * _Nullable members) {
        // 只获取管理员.
        if (!error) {
            for (NIMChatroomMember *memb in members) {
                if (memb.type == NIMChatroomMemberTypeManager) {
                    [self.managerlist addObject:memb];
                }
            }
        }
    }];
}

- (void)audienceListPerMin{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30 block:^(NSTimer * _Nonnull timer) {
        NIMChatroomMemberRequest *request = [[NIMChatroomMemberRequest alloc] init];
        request.roomId = self.roomid;
        request.type = NIMChatroomFetchMemberTypeTemp; // 临时成员
        request.limit = 100;
        [[NIMSDK sharedSDK].chatroomManager fetchChatroomMembers:request completion:^(NSError * _Nullable error, NSArray<NIMChatroomMember *> * _Nullable members) {
            if (!error) {
                [self.audiencelist removeAllObjects];
                [self.audiencelist addObjectsFromArray:self.managerlist];
                [self.audiencelist addObjectsFromArray:members];
                self.maskview.countL.text = [NSString stringWithFormat:@"%ld", self.audiencelist.count];
                [self.maskview.collectionView reloadData];
            }
        }];
    } repeats:YES];
    
}


# pragma mark - 观众列表 delegate DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.audiencelist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AudienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID_audience forIndexPath:indexPath];
    
    [cell.img sd_setImageWithURL:self.audiencelist[indexPath.row].roomAvatar.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 点击头像, 连麦, 给房管
}
/*
#pragma mark - 观众列表 flowlayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(36, 36);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}
*/
#pragma mark - 聊天室 delegate && datasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.danmulist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID_text forIndexPath:indexPath];
    NSString *from = self.danmulist[indexPath.row].from;
    NSString *text = self.danmulist[indexPath.row].text;
    NSString *total = [NSString stringWithFormat:@"%@:%@", from, text];
    cell.textL.text = total;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [UIView new];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *from = self.danmulist[indexPath.row].from;
    NSString *text = self.danmulist[indexPath.row].text;
    NSString *total = [NSString stringWithFormat:@"%@:%@", from, text];
    CGFloat height = [total heightForFont:[UIFont systemFontOfSize:14] width:260];
    return height > 30 ? height + 16 : 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // todo: 主播, 管理员踢人封禁操作  view
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 聊天室

- (void)enterChatroom{
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId = self.roomid;
    request.roomExt = @"ext";
    request.roomAvatar = [userDefault objectForKey:user_userimg];
    request.roomNickname = [userDefault objectForKey:user_nickname];
    request.roomNotifyExt = @"";
    request.retryCount = 5;
    [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom, NIMChatroomMember * _Nullable me) {
        if (!error) {
            NIMTipObject *tipObject = [[NIMTipObject alloc] init];
            NIMMessage *message = [[NIMMessage alloc] init];
            message.messageObject = tipObject;
            message.text = @"我进入了直播间";
            NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
            [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
        }
    }];
}

// 发送消息回调
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    if (error) {
        NSError *err;
        [[NIMSDK sharedSDK].chatManager resendMessage:message error:&err];
        NSLog(@"error %@", error);
    } else {
        //NSLog(@"message %@", message);
    }
}

// 收到聊天室消息
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    
    // 处理消息
    NSMutableArray<NIMMessage *> *msgs = [NSMutableArray<NIMMessage *> array];
    for (NIMMessage *message in messages) {
        if (message.messageType == NIMMessageTypeNotification) {
            // 聊天室通知: 忽略...
            
        } else if([message.text isEqualToString:@"gift..."]) {
            // 礼物消息
            NSString *giftID = [message.remoteExt objectForKey:@"giftID"];
            NSString *from = [message.remoteExt objectForKey:@"from"];
            [self.giftlist addObject:giftID];
            if (self.giftlist.count == 1) {
                [self beginGiftAnimation];
            }
            message.text = [NSString stringWithFormat:@"%@送出了一个礼物", from];
            [msgs addObject:message];
        } else if ([message.text isEqualToString:@"redbag..."]){
            // 红包消息
            NSDictionary *dic = message.remoteExt;
            [self tanchuhongbao:dic];
            message.text = [NSString stringWithFormat:@"%@送出了一个红包", message.from];
            [msgs addObject:message];
        } else if([message.text isEqualToString:@"lianmai..."]){
            NSDictionary *dic = message.remoteExt;
             //dic = @{@"type":@(NIMMyNotiTypeConnectMic), @"lianmaiid": model.userId}
            NIMMyNotiType type = [dic jsonInteger:@"type"];
            if (type == NIMMyNotiTypeConnectMic) {
                NSString *lianmaiid = [dic objectForKey:@"lianmaiid"];
                if ([self.accid isEqualToString:lianmaiid]) {
                    
                    [self joinLianmai];
                }
            } else if (type == NIMMyNotiTypeDisconnect) {
                [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
                [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
                [self.displayView removeFromSuperview];
                self.displayView = nil;
                [self liveplayer];
                self.maskview.leaveMeeting.hidden = YES;
                [self.view showWarning:@"主播终止了你的连麦"];
            }
            
            
        } else {
            [msgs addObject:message];
        }
        
    }
    
    NSInteger remove = self.danmulist.count + msgs.count - 50;
    for (int i = 0; i < remove; i++) {
        [self.danmulist removeFirstObject];
    }
    [self.danmulist addObjectsFromArray:msgs];
    [self.tableView reloadData];
    if (self.danmulist.count > 5) [self.tableView scrollToBottom];
}


// 收到自定义通知
-(void)onReceiveCustomSystemNotification:(NIMCustomSystemNotification *)notification{
    //NSString *content = notification.content;
    
}

// 聊天室连接状态
- (void)chatroom:(NSString *)roomId connectionStateChanged:(NIMChatroomConnectionState)state{
    
    NSLog(@"state: %ld", state);
}
// 自动登录失败
- (void)chatroom:(NSString *)roomId autoLoginFailed:(NSError *)error{
    
}
// 聊天室关闭, 或者被踢
- (void)chatroom:(NSString *)roomId beKicked:(NIMChatroomKickReason)reason{
    
}






- (void)addNotification{
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
        {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if (self.presentingViewController) {
                        
                    }}];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                [self.liveplayer switchContentUrl:[NSURL URLWithString:urls]];
                [self.liveplayer prepareToPlay];
                [self.liveplayer play];
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

#pragma mark 礼物动画

- (void)beginGiftAnimation{
    if (!self.giftlist.count) return;
    
    NSString *giftid = self.giftlist.firstObject;
    NSInteger section = giftid.integerValue / 10;
    NSInteger row = giftid.integerValue % 10;
    GiftModel *model = self.giftV.giftlist[section][row];
    
    [GiftAnimation giftWithImage:model.name animationType:model.animation addedToView:self.maskview duration:model.duration audioName:model.audioName conpletion:^{
        [self.giftlist removeFirstObject];
        [self beginGiftAnimation];
    }];
}


#pragma mark 懒加载

- (NSMutableArray<NIMChatroomMember *> *)audiencelist{
    if (!_audiencelist) {
        _audiencelist = [NSMutableArray<NIMChatroomMember *> array];
    }
    return _audiencelist;
}

- (NSMutableArray<NIMMessage *> *)danmulist{
    if (!_danmulist) {
        _danmulist = [NSMutableArray<NIMMessage *> array];
    }
    return _danmulist;
}

- (NSMutableArray<NIMChatroomMember *> *)managerlist{
    if (!_managerlist) {
        _managerlist = [NSMutableArray<NIMChatroomMember *> array];
    }
    return _managerlist;
}

- (NSMutableArray *)giftlist{
    if (!_giftlist) {
        _giftlist = [NSMutableArray array];
    }
    return _giftlist;
}

- (id<NELivePlayer>)liveplayer{
    if (!_liveplayer) {
        _liveplayer = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:urls]];
        if (!_liveplayer) {
            NSLog(@"播放器初始化失败");
        }
        UIView * playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _liveplayer.view.frame = playerView.bounds;
        [_liveplayer prepareToPlay];
        _liveplayer.shouldAutoplay = YES;
        [self.view insertSubview:_liveplayer.view belowSubview:self.scrollV];
        [_liveplayer play];
    }
    return _liveplayer;
}

- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scrollV.contentSize = CGSizeMake(kScreenW*2, kScreenH);
        _scrollV.contentOffset = CGPointMake(kScreenW, 0);
        _scrollV.pagingEnabled = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.bounces = NO;
        [self.view addSubview:_scrollV];
    }
    return _scrollV;
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

- (PortraitFullMaskView *)maskview{
    if (!_maskview) {
        _maskview = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PortraitFullMaskView class]) owner:nil options:nil].firstObject;
        _maskview.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
        [self.maskview.user_img sd_setImageWithURL:self.zhubo_img.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
        _maskview.user_name.text = self.zhubo_name;
        _maskview.user_id.text = self.zhubo_uid;
        _maskview.countL.text = @"0";
        NSString *img = self.weddingtype ?@"zb_xi": @"zb_zhong";
        _maskview.bgView.image = [UIImage imageNamed:img];
        
        [self configBottomBtn:self.maskview];
        _maskview.textField.inputAccessoryView = [UIView new];
        _maskview.tableView.tableFooterView = [UIView new];
        _maskview.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = self.maskview.tableView;
        self.collectionView = self.maskview.collectionView;
        [self registerCell];
        [self shareBtnClick];
        _maskview.tableView.delegate = self;
        _maskview.tableView.dataSource = self;
        _maskview.collectionView.delegate = self;
        _maskview.collectionView.dataSource = self;
        [self.scrollV addSubview:_maskview];
        
    }
    return _maskview;
}

- (void)taptap{
    if (_giftV) {
        [UIView animateWithDuration:0.5 animations:^{
            _giftV.frame = CGRectMake(0, kScreenH, kScreenW, 230);
        }];
    }
}

- (GiftView *)giftV{ 
    if (!_giftV) {
        _giftV = [[GiftView alloc] initWithDirection:screenDirectionV];
        [self.maskview addSubview:_giftV];
        
        _giftV.yuE.text = self.yue;
        
        [_giftV.send bk_addEventHandler:^(id sender) {
            
            NSString *uid = [userDefault objectForKey:user_uid];
            NSString *token = [userDefault objectForKey:user_token];
            NSString *giftid = [NSString stringWithFormat:@"%ld%ld", _giftV.currentIndex.section, _giftV.currentIndex.row];
            NSIndexPath *index = _giftV.currentIndex;
            GiftModel *model = _giftV.giftlist[index.section][index.row];
            NSDictionary *para = @{@"uid": uid, @"token": token, @"giftinfo_giftid": model.towuid};
            
            [DNNetworking postWithURLString:post_sendgift parameters:para success:^(id obj) {
                NSString *code = [obj objectForKey:@"code"];
                if ([code isEqualToString:@"1000"]) {
                    NIMMessage *msg = [[NIMMessage alloc] init];
                    NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
                    msg.text = @"gift...";
                    NSString *from = self.nickName;
                    msg.remoteExt = @{@"giftID": giftid, @"from": from};
                    [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:nil];
                    NSString *data = [obj objectForKey:@"data"];
                    _giftV.yuE.text = [NSString stringWithFormat:@"%.2f", data.floatValue];
                    [self.giftlist addObject:giftid];
                    if (self.giftlist.count == 1) {
                        [self beginGiftAnimation];
                    }
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"余额不足" message:@"请充值" preferredStyle: UIAlertControllerStyleAlert];
                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil];
                    [alert addAction:act];
                    [self.navigationController presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSError *error) {
                [self.view showWarning:@"网络错误"];
            }];
            [UIView animateWithDuration:0.5 animations:^{
                _giftV.frame = CGRectMake(0, kScreenH, kScreenW, 230);
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        [_giftV.chongzhi bk_addEventHandler:^(id sender) {
            // todo: 充值
            rechargeVC *vc = [[rechargeVC alloc] init];
            vc.moneystr = self.yue;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftV;
}

- (qiangRedbagView *)qiangRedbag{
    if (!_qiangRedbag) {
        _qiangRedbag = [[qiangRedbagView alloc] init];
        [self.maskview addSubview:_qiangRedbag];
        _qiangRedbag.hidden = YES;
        [_qiangRedbag.cancel bk_addEventHandler:^(id sender) {
            _qiangRedbag.hidden = YES;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _qiangRedbag;
}

- (SendRedBagView *)redBag{
    if (!_redBag) {
        _redBag = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SendRedBagView class]) owner:nil options:nil].firstObject;
        _redBag.frame = CGRectMake(30, 100, kScreenW- 60, 360);
        [self.maskview addSubview:_redBag];
        _redBag.hidden = YES;
        [_redBag.cancelBtn bk_addEventHandler:^(id sender) {
            _redBag.hidden = YES;
            [self.view endEditing:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [_redBag.sendBtn bk_addEventHandler:^(id sender) {
            [self sendRedBag];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _redBag;
}

- (void)sendRedBag{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *money =_redBag.money.text;
    NSString *number = _redBag.number.text;
    BOOL isnormal = !_redBag.isnormal;
    
    [DNNetworking postWithURLString:post_sendRedbag parameters:@{@"uid": uid, @"token": token, @"bag_money": money, @"bag_type": @(isnormal), @"bag_count": number} success:^(id obj) {
        _redBag.hidden = YES;
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
          
            NIMMessage *message = [[NIMMessage alloc] init];
            NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
            message.text = @"redbag...";
            message.remoteExt = data;
            [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
            
            [self tanchuhongbao:data];
            [self.view endEditing:YES];
        } else if([code isEqualToString:@"990"]) {
            [self.view showWarning:@"余额不足"];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
}

- (void)tanchuhongbao:(NSDictionary *)data{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundImage:[UIImage imageNamed:@"zb_hb_img"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setTitle:@"" forState:UIControlStateNormal];
    btn.frame = CGRectMake((kScreenW - 150)/ 2, (kScreenH - 110)/ 2, 150, 110);
    [btn bk_addEventHandler:^(id sender) {
        // 拆红包
        btn.enabled = NO;
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSString *bagid = [data objectForKey:@"bag_id"];
        NSString *bag_money = [data objectForKey:@"bag_money"];
        NSString *bag_type = [data objectForKey:@"bag_type"];
        NSString *bag_count = [data objectForKey:@"bag_count"];
        [DNNetworking postWithURLString:post_chaiRedbag parameters:@{@"uid": uid, @"token": token, @"bag_id": bagid, @"bag_money": bag_money, @"bag_type": bag_type, @"bag_count": bag_count} success:^(id obj) {
            NSString *code = [obj objectForKey:@"code"];
            
            if ([code isEqualToString:@"1000"]) {
                // 拆红包成功
                NSDictionary *data = [obj objectForKey:@"data"];
                self.redbaglistV.redbagID = [data objectForKey:@"bag_id"];
                self.qiangRedbag.from.text = [NSString stringWithFormat:@"抢到\"%@\"的红包", [data objectForKey:@"username"]];
                self.qiangRedbag.money.text = [NSString stringWithFormat:@"%.2lf", [[data objectForKey:@"money"] floatValue]];
                self.qiangRedbag.sucess.text = @"已存入余额";
                [self.qiangRedbag.detail removeAllTargets];
                [self.qiangRedbag.detail bk_addEventHandler:^(id sender) {
                    NSLog(@"点击查看详情");
                    self.redbaglistV.hidden = NO;
                    [self.redbaglistV netWorking];
                    self.qiangRedbag.hidden = YES;
                } forControlEvents:UIControlEventTouchUpInside];
                self.qiangRedbag.hidden = NO;
            } else if ([code isEqualToString:@"990"]){
                self.qiangRedbag.money.text = @"";
                self.qiangRedbag.from.text = [NSString stringWithFormat:@"\"%@\"的红包", [data objectForKey:@"username"]];
                self.qiangRedbag.sucess.text = @"手慢了,红包已领完~~";
                [self.qiangRedbag.detail removeAllTargets];
                [self.qiangRedbag.detail bk_addEventHandler:^(id sender) {
                    NSLog(@"点击查看详情");
                    self.redbaglistV.hidden = NO;
                    
                    [self.redbaglistV netWorking];
                    self.qiangRedbag.hidden = YES;
                } forControlEvents:UIControlEventTouchUpInside];
                self.qiangRedbag.hidden = NO;
            }
            [btn removeFromSuperview];
        } failure:^(NSError *error) {
            btn.enabled = YES;
            [self.view showWarning:@"网络错误"];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (RedbagDetailListView *)redbaglistV{
    if (!_redbaglistV) {
        _redbaglistV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RedbagDetailListView class]) owner:nil options:nil].firstObject;
        _redbaglistV.hidden = YES;
        [self.maskview addSubview:_redbaglistV];
        [_redbaglistV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(80);
            make.bottom.equalTo(-60);
            make.left.equalTo(60);
            make.right.equalTo(-60);
        }];
        
        [_redbaglistV.cancel bk_addEventHandler:^(id sender) {
            _redbaglistV.hidden = YES;
            _redbaglistV.datalist = nil;
            _redbaglistV.imaV.image = [UIImage imageNamed:@"touxiang"];
            _redbaglistV.from.text = @"谁的红包?";
            _redbaglistV.total.text = @"0.00";
            _redbaglistV.last.text = @"0.00";
        } forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _redbaglistV;
}






#pragma mark - initialize 初始化

- (instancetype)initWithChatroomID:(NSString *)roomid Url:(NSString *)url meetingname:(NSString *)meetingname{
    self = [super init];
    if (self) {
        self.url = url;
        self.roomid = roomid;
        self.zhubo_uid = meetingname;
    }
    return self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
