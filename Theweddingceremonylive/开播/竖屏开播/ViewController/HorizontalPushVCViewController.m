//
//  HorizontalPushVCViewController.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HorizontalPushVCViewController.h"
// function

#import <IQKeyboardManager.h>
#import "NSDictionary+NTESJson.h"
#import "RedbagDetailListView.h"

// model
#import "GiftAnimation.h"


// view
#import "ShuPingKaiboMaskView.h"
#import "AudienceCell.h"
#import "DanmuCell.h"
#import "SendRedBagView.h"
#import "qiangRedbagView.h"
#import "GiftView.h"


// viewcontroller
#import "rechargeVC.h"
#define cellID_text @"text"
#define cellID_audience @"audience"

@interface HorizontalPushVCViewController ()<NIMNetCallManagerDelegate, NIMChatroomManagerDelegate, NIMChatManagerDelegate,  UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *localPreView;
@property (nonatomic, strong) ShuPingKaiboMaskView *maskview;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *lianmaiV;
@property (nonatomic, strong) SendRedBagView *redBag;
@property (nonatomic, strong) qiangRedbagView *qiangRedbag;
@property (nonatomic, strong) GiftView *giftV;
@property (nonatomic, strong) RedbagDetailListView *redbaglistV;


@property (nonatomic, strong) NIMNetCallMeeting *meeting;
@property (nonatomic, copy) NSString *roomid;
@property (nonatomic, copy) NSString *pushUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSString *yue;

@property (nonatomic, strong) NSMutableArray<NIMChatroomMember *> *audiencelist;
@property (nonatomic, strong) NSMutableArray<NIMMessage *> *danmulist;
@property (nonatomic, strong) NSMutableArray<NIMChatroomMember *> *managerlist;
@property (nonatomic, strong) NSMutableArray *giftlist;

@property (nonatomic, assign) BOOL isMute;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation HorizontalPushVCViewController


#pragma mark - life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nickName = [userDefault objectForKey: user_nickname];
    self.count = 0;
    
    
    // 创建直播间
    [self reserveMeeting];
    // 加入直播间
    [self joinMeeting];
    // 进入聊天室
    [self enterChatroom];
    // mask view
    [self configMaskview];
    
    // 获取观众 / 每分钟
    [self chatroomManager];
    [self audienceListPerMin];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [self setUpsth];
    // 打开摄像头预览
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:[self para]];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //关闭键盘相应
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowshow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidehide:) name: UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:self.meeting];
    [[NIMSDK sharedSDK].chatroomManager exitChatroom:self.roomid completion:^(NSError * _Nullable error) {
        
    }];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.timer invalidate];
    self.timer = nil;
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager removeDelegate:self];
    
    [self.view removeAllSubviews];
}

- (void)dealloc{
    
}

- (void)setUpsth
{
    self.isMute = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.view.backgroundColor = UIColorHex(0xdfe2e6);
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager addDelegate:self];
}

#pragma mark - mask view

- (void)configMaskview{
    self.maskview = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShuPingKaiboMaskView class]) owner:nil options:nil].firstObject;
    [self.maskview.icon sd_setImageWithURL:[NSURL URLWithString: [userDefault objectForKey:user_userimg]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.maskview.nameL.text = [userDefault objectForKey:user_nickname];
    self.maskview.labelCount.text = [NSString stringWithFormat:@"%ld", self.count];
    self.maskview.tableView.delegate = self;
    self.maskview.tableView.dataSource = self;
    self.maskview.collectionView.delegate = self;
    self.maskview.collectionView.dataSource = self;
    [self registerCell];
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _scrollV.contentSize = CGSizeMake(kScreenW*2, kScreenH);
    _scrollV.contentOffset = CGPointMake(kScreenW, 0);
    _scrollV.bounces = NO;
    _scrollV.pagingEnabled = YES;
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.showsVerticalScrollIndicator = NO;
    [self scrollviewBtnEvent];
    NSString *img;// = self.weddingtype ?@"zb_xi": @"zb_zhong";
    switch (self.weddingtype) {
        case weddingType_zhong:
            img = @"zb_zhong";
            break;
        case weddingType_xi:
            img = @"zb_xi";
            break;
        case weddingType_none:
            self.maskview.bgView.hidden = YES;
            break;
        default:
            break;
    }
    
    self.maskview.bgView.image = [UIImage imageNamed:img];
    self.maskview.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
    self.maskview.textField.inputAccessoryView = [UIView new];
    [self.scrollV addSubview:self.maskview];
    [self.view insertSubview:_scrollV atIndex:0];
}
#pragma mark 注册 cell
- (void)registerCell{
    
    [self.maskview.tableView registerClass:[DanmuCell class] forCellReuseIdentifier:cellID_text];
    [self.maskview.collectionView registerClass:[AudienceCell class] forCellWithReuseIdentifier:cellID_audience];
}

#pragma mark - 底部按钮功能
- (void)scrollviewBtnEvent{
    [self.maskview.closeBen bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.redbagBtn bk_addEventHandler:^(id sender) {
        // 红包
        self.redBag.hidden = NO;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.duanKaiLianmai bk_addEventHandler:^(id sender) {
        // 断开连麦
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定断开连麦?" preferredStyle:1];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.maskview.duanKaiLianmai.hidden = YES;
            
            NIMMessage *message = [[NIMMessage alloc] init];
            message.text = @"lianmai...";
            message.remoteExt = @{@"type":@(NIMMyNotiTypeDisconnect)};
            NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
            [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
            [self.view showWarning:@"正在断开联麦..."];
            /*
            NIMCustomSystemNotification *noti = [[NIMCustomSystemNotification alloc] initWithContent:[@{@"type":@(NIMMyNotiTypeConnectMic)} jsonBody]];
            noti.sendToOnlineUsersOnly = YES;
            NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
            [[NIMSDK sharedSDK].systemNotificationManager sendCustomNotification:noti toSession:session completion:^(NSError * _Nullable error) {
                if (!error) {
                    [self.view showWarning:@"正在断开联麦..."];
                }
            }];*/
        }];
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [vc addAction:act1];
        [vc addAction:act2];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.sendMsgBtn bk_addEventHandler:^(id sender) {
        // 弹出键盘
        [self.maskview.textField becomeFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.send bk_addEventHandler:^(id sender) {
        // 发送文字消息
        NSString *text = self.maskview.textField.text;
        if (!text.length) return;
        NIMMessage *msg = [[NIMMessage alloc] init];
        msg.text = text;
        msg.from = self.nickName;
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        NSError *error;
        [[NIMSDK sharedSDK].chatManager sendMessage:msg toSession:session error:&error];
        if (self.danmulist.count > 50){
            [self.danmulist removeFirstObject];
        }
        [self.danmulist addObject:msg];
        [self.maskview.tableView reloadData];
        if (self.danmulist.count > 5) [self.maskview.tableView scrollToBottom];
        self.maskview.textField.text = @"";
        [self.maskview.textField resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.jingyinBtn bk_addEventHandler:^(id sender) {
        self.isMute = !self.isMute;
        NSString *img = self.isMute ? @"zb_sound_y": @"zb_sound";
        [self.maskview.jingyinBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [[NIMAVChatSDK sharedSDK].netCallManager setMute:self.isMute];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.maskview.isBack bk_addEventHandler:^(id sender) {
        // 切换前后摄像头
        self.camera = !self.camera;
        [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:self.camera];
    } forControlEvents:UIControlEventTouchUpInside];
    
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
    
    NIMChatroomMember *model = self.audiencelist[indexPath.row];
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:user_nickname message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"设为管理员" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NIMChatroomMemberUpdateRequest *request = [[NIMChatroomMemberUpdateRequest alloc] init];
        request.roomId = self.roomid;
        request.userId = model.userId;
        request.enable = YES;
        request.notifyExt = @"";
        [[NIMSDK sharedSDK].chatroomManager markMemberManager:request completion:^(NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error);
            }else {
            // 改变本地数据
                model.type = NIMChatroomMemberTypeManager;
                [self.audiencelist removeObject:model];
                [self.audiencelist insertObject:model atIndex:0];
                [self.managerlist insertObject:model atIndex:0];
            }
        }];
        
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"联麦" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NIMMessage *message = [[NIMMessage alloc] init];
        message.text = @"lianmai...";
        message.remoteExt = @{@"type":@(NIMMyNotiTypeConnectMic), @"lianmaiid": model.userId};
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
        [self.view showWarning:@"正在申请联麦..."];
        /*  自定义通知发送连麦请求
        NIMCustomSystemNotification *noti = [[NIMCustomSystemNotification alloc] initWithContent:[@{@"type":@(NIMMyNotiTypeConnectMic), @"lianmaiid": model.userId} jsonBody]];
        noti.sendToOnlineUsersOnly = YES;
        NIMSession *session = [NIMSession session:self.roomid type:NIMSessionTypeChatroom];
        [[NIMSDK sharedSDK].systemNotificationManager sendCustomNotification:noti toSession:session completion:^(NSError * _Nullable error) {
            if (!error) {
                [self.view showWarning:@"正在申请联麦..."];
            } else {
                NSLog(@"%@", error);
            }
        }];*/
        
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"禁言" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NIMChatroomMemberUpdateRequest *request = [[NIMChatroomMemberUpdateRequest alloc] init];
        request.roomId = self.roomid;
        request.userId = model.userId;
        request.enable = YES;
         [[NIMSDK sharedSDK].chatroomManager updateMemberMute:request completion:^(NSError * _Nullable error) {
             if (!error) {
                 [self.view showWarning:[NSString stringWithFormat: @"已禁言用户%@", model.roomNickname]];
             } else {
                 [self.view showWarning:@"禁言失败了, 请重试"];
             }
         }];
    }];
    UIAlertAction *act4 = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:act1];
    [alertC addAction:act2];
    [alertC addAction:act3];
    [alertC addAction:act4];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
    
}

- (void)chatroomManager{
    // 获取管理员
    NIMChatroomMemberRequest *request = [[NIMChatroomMemberRequest alloc] init];
    request.roomId = self.roomid;
    request.type = NIMChatroomFetchMemberTypeRegular; // 所有固定成员: 创建者, 管理员...
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
        // 请求观众
        NIMChatroomMemberRequest *request = [[NIMChatroomMemberRequest alloc] init];
        request.roomId = self.roomid;
        request.type = NIMChatroomFetchMemberTypeTemp; // 临时成员
        request.limit = 100;
        [[NIMSDK sharedSDK].chatroomManager fetchChatroomMembers:request completion:^(NSError * _Nullable error, NSArray<NIMChatroomMember *> * _Nullable members) {
            if (!error) {
                [self.audiencelist removeAllObjects];
                [self.audiencelist addObjectsFromArray:self.managerlist];
                [self.audiencelist addObjectsFromArray:members];
                self.maskview.labelCount.text = [NSString stringWithFormat:@"%ld", self.audiencelist.count];
                self.count = members.count;
                [self.maskview.collectionView reloadData];
            }
        }];
        // 发送测试在线状态
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSString *count = [NSString stringWithFormat:@"%ld", self.count];
        NSDictionary *para = @{@"uid": uid, @"token": token, @"renshu": count, @"ordersn": self.orderID, @"direction": @"1"};
        [DNNetworking postWithURLString:post_zhiboing parameters:para success:^(id obj) {
            NSLog(@"................主播正在直播.............");
        } failure:^(NSError *error) {
            [self.view showWarning:@"网络错误"];
        }];
        
    } repeats:YES];
    
}

/*
#pragma mark - 观众列表 flowlayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(36, 36);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}*/

#pragma mark - tableview delegate && datasourse
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
    request.roomNotifyExt = @"";
    request.roomAvatar = [userDefault objectForKey: user_userimg];
    request.roomNickname = [userDefault objectForKey: user_nickname];
    request.retryCount = 5;
    [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom, NIMChatroomMember * _Nullable me) {
        NSLog(@"进入聊天室成功 roomID: %@", chatroom.roomId);
    }];
}

// 收到聊天室消息
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    // 处理消息
    NSMutableArray<NIMMessage *> *msgs = [NSMutableArray<NIMMessage *> array];
    for (NIMMessage *message in messages) {
        if (message.messageType == NIMMessageTypeNotification) {
            // 聊天室通知
            
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
            message.text = [NSString stringWithFormat:@"%@送出了一个红包", [dic objectForKey:@"username"]];
            [msgs addObject:message];
        } else if ([message.text isEqualToString:@"lianmai..."]){
            self.maskview.duanKaiLianmai.hidden = YES;
        }else {
            [msgs addObject:message];
        }
        
    }
    
    NSInteger remove = self.danmulist.count + msgs.count - 50;
    for (int i = 0; i < remove; i++) {
        [self.danmulist removeFirstObject];
    }
    [self.danmulist addObjectsFromArray:msgs];
    [self.maskview.tableView reloadData];
    if (self.danmulist.count > 5) [self.maskview.tableView scrollToBottom];
}

- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    
    if (error) {
        NSError *err;
        [[NIMSDK sharedSDK].chatManager resendMessage:message error:&err];
        //NSLog(@"error %@", error);
    } else {
        NSLog(@"message %@", message);
    }
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

#pragma mark - NIMNetCallManager   互动直播接口

// 创建直播间
- (void)reserveMeeting{
    self.meeting = [[NIMNetCallMeeting alloc] init];
    self.meeting.name = [userDefault objectForKey:user_uid]; // 使用 UID 作为互动直播间 name.
    [[NIMAVChatSDK sharedSDK].netCallManager reserveMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        NSLog(@" reserve meeting error %@", error);
        //if (!error) NSLog(@"-------创建 metting 成功------  meeting: %@", meeting);
    }];
}


// 加入互动直播间
- (void)joinMeeting{
    
    
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    self.meeting.option = option;
    option.enableBypassStreaming = YES;
    //NSString *url = [self.pushUrl componentsSeparatedByString:@"?"].firstObject;
    option.bypassStreamingUrl = self.pushUrl;
    NSLog(@"%@", self.pushUrl);
    option.videoCaptureParam = [self para];
    // 开启该选项，以在远端设备旋转时在本端自动调整角度
    option.autoRotateRemoteVideo = NO;
    // 编码器
    option.preferredVideoEncoder = NIMNetCallVideoCodecDefault;
    // 解码器
    option.preferredVideoDecoder = NIMNetCallVideoCodecDefault;
    // 最大编码 码率 不指定自动选择
    //option.videoMaxEncodeBitrate
    // 语音降噪
    option.audioDenoise = YES;
    // 人声检测
    option.voiceDetect = NO;
    // 服务器录制视频
    option.serverRecordVideo = YES;
    // 服务器录制音频
    option.serverRecordAudio = YES;
    // 服务器录制
    option.bypassStreamingServerRecording = YES;
    // 扩展消息
    option.extendMessage = @"扩展消息";
    option.bypassStreamingVideoMixMode = NIMNetCallVideoMixModeCustomLayout;
    option.bypassStreamingVideoMixCustomLayoutConfig = @"{\"version\":0,\"set_host_as_main\":true,\"host_area\":{\"adaption\":1},\"special_show_mode\":true,\"n_host_area_number\":1,\"n_host_area_0\":{\"position_x\":0,\"position_y\":0,\"width_rate\":10000,\"height_rate\":10000,\"adaption\":0}}";
    self.meeting.actor = YES;
    
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:self.meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        [[NIMAVChatSDK sharedSDK].netCallManager setSpeaker:YES];
        NSLog(@"join error %@", error);
        if (!error) NSLog(@"-------加入 metting 成功------  meeting: %@", meeting);
    }];
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

#pragma mark  - NIMNetCallManagerDelegate

//本地摄像头预览就绪回调


// 获取摄像头画面成功回调
- (void)onLocalDisplayviewReady:(UIView *)displayView{
    
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
    
    self.maskview.duanKaiLianmai.hidden = NO;
    NSLog(@"uid: %@ 加入", uid);
}

// 用户离开房间通知
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting{
    NSLog(@"uid: %@ 离开", uid);
    self.lianmaiV.hidden = YES;
    self.lianmaiV = nil;
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
    UIImage *img = [UIImage imageWithCGImage:image];
    self.lianmaiV.image = img;
}
#pragma mark - 懒加载

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

- (UIImageView *)lianmaiV{
    if (!_lianmaiV) {
        _lianmaiV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        //_lianmaiV.hidden = YES;
        [self.view insertSubview:_lianmaiV aboveSubview:self.displayView];
    }
    return _lianmaiV;
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
                    msg.remoteExt = @{@"giftID": giftid, @"from": self.nickName};
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

- (BOOL)shouldAutorotate
{
    return YES;
}

//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}




- (instancetype)initWithChatroomID:(NSString *)roomid pushurl:(NSString *)pushUrl yue:(CGFloat)yue{
    self = [super init];
    if (self) {
        self.roomid = roomid;
        self.pushUrl = pushUrl;
        self.yue = [NSString stringWithFormat:@"%.2f", yue];
    }
    return self;
}

#pragma mark - receiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
