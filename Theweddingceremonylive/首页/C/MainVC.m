//
//  MainVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainVC.h"
// model
#import "WeddingVideoModel.h"
#import "MainNvwaModel.h"
#import "TuiJianModel.h"
#import "MainModel.h"

// view / cell
#import "MainCell.h"
#import "BannerView.h"
#import "MainHeaderView.h"
#import "MainNaviBar.h"

// vc
#import "WKWedViewController.h"
#import "NvWaPinDaoVC.h"
#import "TuiJianVC.h"
#import "WeddingVideoVC.h"
#import "SearchViewController.h"
#import "WeddingLiveVC.h"
#import "WMPlayerVC.h"

#import "shopdetalisVC.h"
#import "HMScannerController.h"

@interface MainVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BannerViewDelegate, BannerViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<TuiJianModel *> *business;
@property (nonatomic, strong) NSMutableArray<MainModel *> *lunbo;
@property (nonatomic, strong) NSMutableArray<WeddingVideoModel *> *shipin;
@property (nonatomic, strong) MainNvwaModel *nvwamodel;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BannerView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[MainHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    MJWeakSelf
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addHeaderRefresh:^{
        [weakSelf HeaderRefresh];
    }];
    [self HeaderRefresh];
    [self configNaviBar];
    
}

- (void)configNaviBar{
    MainNaviBar *navi = [[NSBundle mainBundle] loadNibNamed:@"MainNaviBar" owner:self options:nil].firstObject;
    navi.frame = CGRectMake(0, 0, kScreenW, 64);
    navi.search = ^(){
        SearchViewController *vc = [[SearchViewController alloc] init];
        vc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
//    navi.saoma = ^(){
//        // todo  添加 扫码按钮点击事件
//        NSString *cardName = @"扫码地址";
//        UIImage *avatar = [UIImage imageNamed:@"avatar"];
//        // 实例化扫描控制器
//        
//        HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
//            NSLog(@"str------%@",stringValue);
//            
//            //self.scanResultLabel.text = stringValue;
//        }];
//        
//        // 设置导航栏样式
//        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
//        
//        // 展现扫描控制器
//        [self showDetailViewController:scanner sender:nil];
//        
//    };
    [self.view addSubview:navi];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)HeaderRefresh{
    
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        [DNNetworking postWithURLString:post_Main parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
            
            NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
            if ([code isEqualToString:@"1000"]) {
                NSDictionary *data = [obj objectForKey:@"data"];
                [self.business removeAllObjects];
                NSArray *busne = [TuiJianModel parse:[data objectForKey:@"business"]];
                [self.business addObjectsFromArray: busne];
                [self.lunbo removeAllObjects];
                NSArray *lunbo = [MainModel parse:[data objectForKey:@"lunbo"]];
                [self.lunbo addObjectsFromArray:lunbo];
                [self.shipin removeAllObjects];
                NSArray *shipin = [WeddingVideoModel parse:[data objectForKey:@"shipin"]];
                [self.shipin addObjectsFromArray:shipin];
                self.nvwamodel = [MainNvwaModel parse:[data objectForKey:@"nvwa"]];
                [self.collectionView reloadData];
            } else {
                //NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
                [self.view showWarning:@"error"];
            }
            
            [self.collectionView endHeaderRefresh];
        } failure:^(NSError *error) {
            
            [self.view showWarning:@"网络错误"];
            [self.collectionView endHeaderRefresh];
        }];
}





#pragma mark collectionView  dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.business.count ? 3 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.shipin.count;
            break;
            case 1:
            return 1;
            case 2:
            return self.business.count;
        default:
            break;
    }
    
    
    return section == 1 ? 1 : 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.shipin[indexPath.row].video_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
            cell.titleL.text = self.shipin[indexPath.row].video_title;
            break;
        case 1:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.nvwamodel.nvwa_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
            cell.titleL.text = self.nvwamodel.nvwa_title;
            break;
        case 2:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.business[indexPath.row].picurl] placeholderImage:[UIImage imageNamed:@"16bi9"]];
            cell.titleL.text = self.business[indexPath.row].name;
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark bannerview datasource  &&  delegate
- (NSInteger)numberOfItemsInCarouselOfBannerView:(BannerView *)banner{
    return self.lunbo.count;
}

- (NSString *)urlForItemAtIndex:(NSInteger)index{
    return self.lunbo[index].picurl;
}

- (void)iCarousel:(iCarousel *)ic didSelectedAtIndex:(NSInteger)index{
    // TODO  添加 title
//    WKWedViewController *web = [[WKWedViewController alloc] initWithTitle:@"" Url:self.lunbo[index].linkurl.xd_URL];
//    [self.navigationController pushViewController:web animated:YES];
//    NSLog(@"点击 index %ld", index);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section ? CGSizeMake(kScreenW, 40) : CGSizeMake(kScreenW, 120 +  kScreenW * 4 / 7 );
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            BannerView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            //BannerView *view = [[NSBundle mainBundle] loadNibNamed:@"BannerView" owner:nil options:nil].firstObject;
            view.frame = CGRectMake(0, 0, kScreenW, 120 +  kScreenW * 4 / 7);
            view.delegate = self;
            view.datasource = self;
            MJWeakSelf
            view.shipin = ^(){
                WeddingVideoVC *vc = [[WeddingVideoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };
            view.zhibo = ^(){
                WeddingLiveVC *vc = [[WeddingLiveVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };
            view.tuijian = ^(){
                TuiJianVC *vc = [[TuiJianVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };
            view.nvwa = ^(){
                NvWaPinDaoVC *vc = [[NvWaPinDaoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            [view reloadData];
            return view;
        } else {
            MainHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                view.title.text = @"女娲频道";
                [view.mask removeAllTargets];
                [view.mask bk_addEventHandler:^(id sender) {
                    NvWaPinDaoVC *VC = [[NvWaPinDaoVC alloc] init];
                    [self.navigationController pushViewController:VC animated:YES];
                    NSLog(@"女娲频道");
                } forControlEvents:UIControlEventTouchUpInside];
            } else {
                view.title.text = @"推荐商家";
                [view.mask removeAllTargets];
                [view.mask bk_addEventHandler:^(id sender) {
                    NSLog(@"推荐商家");
                    TuiJianVC *vc = [[TuiJianVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
                    [self.navigationController pushViewController:vc animated:YES];
                } forControlEvents:UIControlEventTouchUpInside];
            }
            return view;
        }
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            WMPlayerVC *vc = [[WMPlayerVC alloc] initWithUrl:self.shipin[indexPath.row].video_url];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            NvWaPinDaoVC *VC = [[NvWaPinDaoVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:{
            TuiJianModel *model = self.business[indexPath.row];

            shopdetalisVC *vc = [[shopdetalisVC alloc] init];
            vc.businid = [NSString stringWithFormat:@"%ld",(long)model.ident];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    NSLog(@"%ld, %ld", indexPath.section, indexPath.row);
}

#pragma mark 空数据视图 DataSource && delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptyImg"];        // 空数据图片
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    
    [self.collectionView beginHeaderRefresh];
    NSLog(@"empty image tapped");
}
#pragma mark layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenW - 40, (kScreenW - 40) * 9 / 16 + 30);
    }
    return CGSizeMake((kScreenW - 50)/2, ((kScreenW - 50)/2)*9/16 + 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

#pragma mark 懒加载

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        layout.itemSize = CGSizeMake((kScreenW - 50)/2, ((kScreenW - 50)/2)*9/16);
        CGRect frame = CGRectMake(0, 44, kScreenW, self.view.frame.size.height - 64);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray<TuiJianModel *> *)business{
    if (!_business) {
        _business = [NSMutableArray<TuiJianModel *> array];
    }
    return _business;
}

- (NSMutableArray<MainModel *> *)lunbo{
    if (!_lunbo) {
        _lunbo = [NSMutableArray<MainModel *> array];
    }
    return _lunbo;
}

- (NSMutableArray<WeddingVideoModel *> *)shipin{
    if (!_shipin) {
        _shipin = [NSMutableArray<WeddingVideoModel *> array];
    }
    return _shipin;
}

- (void)dealloc{
    
    NSLog(@"观察 VC 释放时机, 检测意外释放 VC 的原因  *****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
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



@end
