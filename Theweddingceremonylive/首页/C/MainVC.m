//
//  MainVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainVC.h"
#import "MainCell.h"
#import "BannerView.h"
#import "MainHeaderView.h"
#import "MainModel.h"
#import "WeddingVideoModel.h"
#import "NvwaModel.h"
#import "TuiJianModel.h"
#import <UIScrollView+EmptyDataSet.h>
#import "MainNaviBar.h"

#import "NvWaPinDaoVC.h"




@interface MainVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BannerViewDelegate, BannerViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<TuiJianModel *> *business;
@property (nonatomic, strong) NSMutableArray<MainModel *> *lunbo;
@property (nonatomic, strong) NSMutableArray<WeddingVideoModel *> *shipin;
@property (nonatomic, strong) NvwaModel *nvwamodel;

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
    [self.view addSubview:navi];
    //self.navigationItem.leftBarButtonItem = nil;
    //self.navigationController.navigationItem.titleView = navi;
    //self.navigationController.navigationBar.topItem.titleView = navi;
    //self.navigationItem.titleView = navi;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
                self.nvwamodel = [NvwaModel parse:[data objectForKey:@"nvwa"]];
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
    return self.shipin.count ? 3 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 1 ? 1 : 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.shipin[indexPath.row].video_img] placeholderImage:[UIImage imageNamed:@""]];
            cell.titleL.text = self.shipin[indexPath.row].video_title;
            break;
        case 1:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.nvwamodel.nvwa_img] placeholderImage:[UIImage imageNamed:@""]];
            cell.titleL.text = self.nvwamodel.nvwa_title;
            break;
        case 2:
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.business[indexPath.row].picurl] placeholderImage:[UIImage imageNamed:@""]];
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
    //self.lunbo[index].linkurl
    NSLog(@"点击 index %ld", index);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section ? CGSizeMake(kScreenW, 40) : CGSizeMake(kScreenW, 120 +  kScreenW * 4 / 7 + 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            BannerView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            //BannerView *view = [[NSBundle mainBundle] loadNibNamed:@"BannerView" owner:nil options:nil].firstObject;
            view.frame = CGRectMake(0, 0, kScreenW, 120 +  kScreenW * 4 / 7 + 40);
            view.delegate = self;
            view.datasource = self;
            MJWeakSelf
            //view.shipin =
            //view.zhibo
            //view.tuijian
            view.nvwa = ^(){
                NvWaPinDaoVC *VC = [[NvWaPinDaoVC alloc] init];
                [weakSelf.navigationController pushViewController:VC animated:YES];
            };
            [view reloadData];
            return view;
        } else {
            MainHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                view.title.text = @"女娲频道";
                [view.mask removeAllTargets];
                [view.mask bk_addEventHandler:^(id sender) {
                    
                    NSLog(@"女娲频道");
                } forControlEvents:UIControlEventTouchUpInside];
            } else {
                view.title.text = @"推荐商家";
                [view.mask bk_addEventHandler:^(id sender) {
                    NSLog(@"推荐商家");
                    
                } forControlEvents:UIControlEventTouchUpInside];
            }
            return view;
        }
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%ld, %ld", indexPath.section, indexPath.row);
}

#pragma mark 空数据视图 DataSource && delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@""];        // 空数据图片
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
