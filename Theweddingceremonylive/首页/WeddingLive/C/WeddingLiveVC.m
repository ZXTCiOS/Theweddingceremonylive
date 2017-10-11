//
//  WeddingLiveVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WeddingLiveVC.h"

// model
#import "WeddingLiveModel.h"

// view . cell
#import "WeddingLivingCell.h"
#import "WeddingLiveFutureCell.h"
#import "WeddingLiveTableCell.h"
// viewcontroller
#import "PortraitFullViewController.h"
#import "HorizontalPushVCViewController.h"
#import "hengpingKaiboVC.h"
#import "hengpingWatchVC.h"
#import "PreLiveVC.h"
#import "PublicVC.h"


@interface WeddingLiveVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) WeddingLiveModel *model;

@property (nonatomic, strong) WeddingLiveDataLivingModel *publiclist;

@property (nonatomic, strong) WeddingLiveDataLivingModel *privatelist;

@property (nonatomic, strong) NSArray<WeddingLiveDataLivingModel *> *futurelist;

@end

@implementation WeddingLiveVC

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netWorking];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"婚礼直播";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLivingCell class]) bundle:nil] forCellReuseIdentifier:@"living"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLiveTableCell class]) bundle:nil] forCellReuseIdentifier:@"collection"];
}

#pragma mark - tabbar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.tabBarController.tabBar setHidden:NO];
}


#pragma mark - networking

- (void)netWorking{
    
    MJWeakSelf
    [self.tableView addHeaderRefresh:^{
        [weakSelf headerRefresh];
    }];
    
    [self headerRefresh];
}

- (void)headerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    //
    [DNNetworking postWithURLString:post_weddinglive parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            //NSDictionary *data = [obj objectForKey:@"data"];
            
            WeddingLiveModel *model = [WeddingLiveModel parse:obj];
            self.model = model;
            self.publiclist = model.data.gk;
            self.privatelist = model.data.sm;
            self.futurelist = model.data.jq;
            [self.tableView reloadData];
            // 下拉刷新时 近期婚礼直播还没显示所以不用刷新
        } else {
            NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
            [self.view showWarning:msg];
        }
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.tableView endHeaderRefresh];
    }];
}




#pragma mark - tableview Delegate && datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;//self.publiclist.count ? 3 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 4;
    if (section == 0) {
        return self.publiclist.room_data.count;
    } else if (section == 1){
        return self.privatelist.room_data.count;
    } else if (section == 2) {
        return self.futurelist.count;
    } return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {   // 横向滑动 cell
        WeddingLiveTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collection" forIndexPath:indexPath];
        WeddingLiveDataLivingModel *model = self.futurelist[indexPath.row];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time doubleValue]];
        cell.dateL.text = [formatter stringFromDate:date];
        cell.countL.text = [NSString stringWithFormat:@"%@场", model.room_renshu];
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
        cell.collectionView.tag = 500 + indexPath.row;
        return cell;
    }
    WeddingLiveDataLiveDataModel *model;
    if (indexPath.section) {
        model = self.privatelist.room_data[indexPath.row];
    } else {
        model = self.publiclist.room_data[indexPath.row];
    }
    WeddingLivingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"living" forIndexPath:indexPath];
    //return cell;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString: model.room_img] placeholderImage:[UIImage imageNamed:@"hlzbfive"]];
    cell.titleL.text = model.room_name;
    cell.countL.text = model.pindao_renshu;
    cell.lockImg.hidden = !indexPath.section;
    if (indexPath.section == 1) {
        cell.lockImg.hidden = NO;
    } else {
        cell.lockImg.hidden = YES;
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 200, 17)];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 112, 12, 100, 17)];
    count.textColor = krgb(51, 51, 51, 1);
    count.textAlignment = NSTextAlignmentRight;
    [view addSubview:title];
    [view addSubview:count];
    switch (section) {
        case 0:{
            title.text = @"全平台直播";
            count.text = [NSString stringWithFormat:@"%@场", self.publiclist.room_renshu];
            if (!self.publiclist.room_renshu) {
                count.text = @"0场";
            }
            [view bk_addEventHandler:^(id sender) {
                PublicVC *vc = [[PublicVC alloc] init];
                vc.type = @"0";
                [self.navigationController pushViewController:vc animated:YES];
            } forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:{
            title.text = @"亲友内部直播";
            count.text = [NSString stringWithFormat:@"%@场", self.privatelist.room_renshu];
            if (!self.privatelist.room_renshu) {
                count.text = @"0场";
            }
            [view bk_addEventHandler:^(id sender) {
                PublicVC *vc = [[PublicVC alloc] init];
                vc.type = @"1";
                [self.navigationController pushViewController:vc animated:YES];
            } forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
            title.text = @"近期婚礼直播";
            count.hidden = YES;
            break;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    view.backgroundColor = krgb(246, 246, 246, 1);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
        return ((kScreenW - 48) / 2) * 4 / 7.0 + 30 + 33;   // 手动计算高度相加  图片宽高比 7:4 其他固定高度
    }
    return (kScreenW - 24) / 7.0 * 4 + 45 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    if (indexPath.row == 1) {
        HorizontalPushVCViewController *vc = [[HorizontalPushVCViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    } else if (indexPath.row == 0){
        // todo: 区别横竖屏   传参
        PortraitFullViewController *vc = [[PortraitFullViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"section %ld, row %ld", indexPath.section, indexPath.row);
    }else if (indexPath.row == 2){
        // todo: 区别横竖屏   传参
        hengpingWatchVC *vc = [[hengpingWatchVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"section %ld, row %ld", indexPath.section, indexPath.row);
    } else if (indexPath.row == 3) {
        hengpingKaiboVC *vc = [[hengpingKaiboVC alloc] initWithChatroomID:@"" pushurl:@"" yue:3];
        //PreLiveVC *vc = [[PreLiveVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }*/
    
    
    if (indexPath.section == 0) {
        WeddingLiveDataLiveDataModel *model = self.publiclist.room_data[indexPath.row];
        if ([model.pindao_diretion isEqualToString:@"0"]) {
            // 横屏
            hengpingWatchVC *vc = [[hengpingWatchVC alloc] initWithChatroomID:model.roomid Url:model.tuilaliu.ret.rtmpPullUrl meetingname:model.uid];
            vc.zhubo_name = model.username;
            vc.zhubo_img = model.picture;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:NO];
        } else {
            PortraitFullViewController *vc = [[PortraitFullViewController alloc] initWithChatroomID:model.roomid Url:model.tuilaliu.ret.rtmpPullUrl meetingname:model.uid];
            vc.zhubo_name = model.username;
            vc.zhubo_img = model.picture;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:NO];
        }
        
    } else if (indexPath.section == 1){
        WeddingLiveDataLiveDataModel *model = self.privatelist.room_data[indexPath.row];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入密码";
        }];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *pwd = alert.textFields.firstObject;
            if (![pwd isEqual:model.order_password]) {
                
                if ([model.pindao_diretion isEqualToString:@"0"]) {
                    // 横屏
                    hengpingWatchVC *vc = [[hengpingWatchVC alloc] initWithChatroomID:model.roomid Url:model.tuilaliu.ret.rtmpPullUrl meetingname:model.uid];
                    vc.zhubo_name = model.username;
                    vc.zhubo_img = model.picture;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:NO];
                } else {
                    PortraitFullViewController *vc = [[PortraitFullViewController alloc] initWithChatroomID:model.roomid Url:model.tuilaliu.ret.rtmpPullUrl meetingname:model.uid];
                    vc.zhubo_name = model.username;
                    vc.zhubo_img = model.picture;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:NO];
                }
                
            } else {
                [self.view showWarning:@"密码错误, 请重新输入"];
            }
        }];
        UIAlertAction *ac1t = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:act];
        [alert addAction:ac1t];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        
    }
}


#pragma mark - collectionView   delegate && datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.futurelist[collectionView.tag - 500].room_data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WeddingLiveFutureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"future" forIndexPath:indexPath];
    WeddingLiveDataLiveDataModel *model = self.futurelist[collectionView.tag - 500].room_data[indexPath.row];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString: model.room_img] placeholderImage:[UIImage imageNamed:@"hlzbfive"]];
    cell.titleL.text = model.room_name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // todo  添加点击事件
    NSLog(@"row:%ld, collection.tag = %ld", indexPath.row, collectionView.tag);
}

#pragma mark - layout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW - 48) / 2, ((kScreenW - 48) / 2) * 4 / 7.0 + 30);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
