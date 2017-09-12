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
    
    self.title = @"婚礼直播";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLivingCell class]) bundle:nil] forCellReuseIdentifier:@"living"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLiveTableCell class]) bundle:nil] forCellReuseIdentifier:@"collection"];
}

#pragma mark - tabbar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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
            self.publiclist = model.data.room_public;
            self.privatelist = model.data.room_private;
            self.futurelist = model.data.room_future;
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
    return 1;//self.publiclist.count ? 3 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return self.futurelist.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {   // 横向滑动 cell
        WeddingLiveTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collection" forIndexPath:indexPath];
        WeddingLiveDataLivingModel *model = self.futurelist[indexPath.row];
        cell.dateL.text = model.date;
        cell.countL.text = [NSString stringWithFormat:@"%@场", model.count];
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
        cell.collectionView.tag = 500 + indexPath.row;
        return cell;
    }
    WeddingLiveDataLiveDataModel *model;
    if (indexPath.section) {
        model = self.privatelist.data[indexPath.row];
    } else {
        model = self.publiclist.data[indexPath.row];
    }
    WeddingLivingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"living" forIndexPath:indexPath];
    return cell;
    [cell.imgV sd_setImageWithURL:model.imgurl.xd_URL placeholderImage:[UIImage imageNamed:@"hlzbfive"]];
    cell.titleL.text = model.title;
    cell.countL.text = model.count;
    cell.lockImg.hidden = !indexPath.section;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 200, 17)];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 112, 12, 100, 17)];
    count.textColor = krgb(51, 51, 51, 1);
    count.textAlignment = NSTextAlignmentRight;
    [view addSubview:title];
    [view addSubview:count];
    switch (section) {
        case 0:
            title.text = @"全平台直播";
            count.text = [NSString stringWithFormat:@"%@场", self.publiclist.count];
            [view bk_addEventHandler:^(id sender) {
                // todo 添加点击更多
                
                
            } forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            title.text = @"亲友内部直播";
            count.text = [NSString stringWithFormat:@"%@场", self.privatelist.count];
            [view bk_addEventHandler:^(id sender) {
                
            } forControlEvents:UIControlEventTouchUpInside];
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
    
    if (indexPath.row) {
        HorizontalPushVCViewController *vc = [[HorizontalPushVCViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    
    // todo: 区别横竖屏   传参
    
    NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
    [decodeParm addObject:@"software"];
    [decodeParm addObject:@"livestream"];
    
//    NELivePlayerViewController *nelpViewController = [[NELivePlayerViewController alloc] initWithURL:@"rtmp://ve266c7be.live.126.net/live/5f581cb50c724380bd08788abe7b0f9d".xd_URL andDecodeParm:decodeParm];
//    [self presentViewController:nelpViewController animated:YES completion:nil];
    
    
    PortraitFullViewController *vc = [[PortraitFullViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"section %ld, row %ld", indexPath.section, indexPath.row);
}


#pragma mark - collectionView   delegate && datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.futurelist[collectionView.tag - 500].data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WeddingLiveFutureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"future" forIndexPath:indexPath];
    WeddingLiveDataLiveDataModel *model = self.futurelist[collectionView.tag - 500].data[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.imgurl.xd_URL placeholderImage:[UIImage imageNamed:@"hlzbfive"]];
    cell.titleL.text = model.title;
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
