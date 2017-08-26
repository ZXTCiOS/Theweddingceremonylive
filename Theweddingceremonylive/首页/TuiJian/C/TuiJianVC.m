//
//  TuiJianVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TuiJianVC.h"
#import "MainCell.h"
#import "tuijianRuseView.h"
#import "TuijianDataModel.h"
#import "SearchViewController.h"

@interface TuiJianVC ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray<TuiJianModel *> *datalist;

@property (nonatomic, strong) NSArray<TuiJjianLunboModel *> *lunbolist;

@end

@implementation TuiJianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部商家";
     [XDFactory addSearchItemForVC:self clickedHandler:^{
         SearchViewController *vc = [[SearchViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
     }];
    [self.collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[tuijianRuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self netWorking];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)netWorking{
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf headerRefresh];
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf footerRefresh];
    }];
    [self headerRefresh];
}
static NSInteger page = 1;
- (void)headerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    //
    [DNNetworking postWithURLString:post_tuijianshangjia parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            //NSDictionary *data = [obj objectForKey:@"data"];
            TuijianDataModel *model = [TuijianDataModel parse:obj];
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:model.data.data];
            self.lunbolist = model.data.lunbo;
            [self.collectionView reloadData];
            page = 1;
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

- (void)footerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    page++;
    [DNNetworking postWithURLString:post_tuijianshangjia parameters:@{@"uid": uid, @"token": token, @"page": @(page)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            
            TuijianDataModel *model = [TuijianDataModel parse:obj];
            [self.datalist addObjectsFromArray:model.data.data];
            [self.collectionView reloadData];
            
            page++;
        } else {
            //NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
            [self.view showWarning:@"error"];
            page--;
        }
        
        [self.collectionView endFooterRefresh];
    } failure:^(NSError *error) {
        page--;
        [self.view showWarning:@"网络错误"];
        [self.collectionView endFooterRefresh];
    }];
}





#pragma collectioin delegate &&  datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleL.text = self.datalist[indexPath.row].name;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.datalist[indexPath.row].picurl] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    tuijianRuseView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.lunbolist.count; i++) {
        [arr addObject:self.lunbolist[i].picurl];
    }
    view.loopV.imageUrls = arr;
    view.block = ^(NSInteger atIndex){
        
        // 点击轮播图跳转.
    };
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, kScreenW * 220 / 760.0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (NSMutableArray<TuiJianModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<TuiJianModel *> array];
    }
    return _datalist;
}



- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *l = [UICollectionViewFlowLayout new];
    l.minimumLineSpacing = 10;
    l.minimumInteritemSpacing = 10;
    l.sectionInset = UIEdgeInsetsMake(30, 15, 30, 15);
    CGFloat width = (kScreenW - 50) / 2;
    l.itemSize = CGSizeMake(width, width * 9 / 16.0 + 30);
    
    self = [super initWithCollectionViewLayout:l];
    if (self) {
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return  self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
