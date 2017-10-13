//
//  SearchResultVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "SearchResultVC.h"
#import "MainCell.h"

#import "TuijianDataModel.h"
#import "WeddingVideoModel.h"


@interface SearchResultVC ()

@property (nonatomic, assign) SearchType type;

@property (nonatomic, strong) NSMutableArray *datalist;

@property (nonatomic, copy) NSString *text;

@end

@implementation SearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索结果";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:@"cell"];
    [self netWorking];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)netWorking{
    
    MJWeakSelf
    
    [self.collectionView addFooterRefresh:^{
        [weakSelf footerRefresh];
    }];
    [self footerRefresh];
}
static NSInteger page = 1;
- (void)footerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    //
    [DNNetworking postWithURLString:post_search parameters:@{@"key": self.text, @"uid": uid, @"token": token, @"type": @(self.type)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            
            switch (self.type) {
                
                case SearchTypeLive:{
                    // 直播列表 model

                    NSArray<WeddingVideoModel *> *arr = [WeddingVideoModel parse:data];
                    [self.datalist addObjectsFromArray:arr];
                }
                    break;
                case SearchTypeVideo:{
                    NSArray<WeddingVideoModel *> *arr = [WeddingVideoModel parse:data];
                    [self.datalist addObjectsFromArray:arr];
                }
                    break;
                case SearchTypeShop:{
                    NSArray<TuiJianModel *> *arr = [TuiJianModel parse:data];
                    [self.datalist addObjectsFromArray:arr];
                }
                    break;
                    
                default:
                    break;
            }
            page++;
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




#pragma collectioin delegate &&  datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (self.type) {
            
        case SearchTypeLive:{
            
            //cell.titleL.text = model.
            //[cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.datalist[indexPath.row].picurl] placeholderImage:[UIImage imageNamed:@""]];
        }
            break;
        case SearchTypeVideo:{
            WeddingVideoModel *model = self.datalist[indexPath.row];
            cell.titleL.text = model.video_title;
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.video_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
        }
            break;
        case SearchTypeShop:{
            TuiJianModel *model = self.datalist[indexPath.row];
            cell.titleL.text = model.name;
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"16bi9"]];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.type) {
            
        case SearchTypeLive:{
            
            //cell.titleL.text = model.
            //[cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.datalist[indexPath.row].picurl] placeholderImage:[UIImage imageNamed:@""]];
        }
            break;
        case SearchTypeVideo:{
            //WeddingVideoModel *model = self.datalist[indexPath.row];
            
        }
            break;
        case SearchTypeShop:{
            //TuiJianModel *model = self.datalist[indexPath.row];
            
            
        }
            break;
            
        default:
            break;
    }
}

- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (instancetype)initWithSearchType:(SearchType)type text:(NSString *)text{
    UICollectionViewFlowLayout *l = [UICollectionViewFlowLayout new];
    l.minimumLineSpacing = 10;
    l.minimumInteritemSpacing = 10;
    l.sectionInset = UIEdgeInsetsMake(30, 15, 30, 15);
    CGFloat width = (kScreenW - 50) / 2;
    l.itemSize = CGSizeMake(width, width * 9 / 16.0 + 30);
    
    self = [super initWithCollectionViewLayout:l];
    if (self) {
        
        self.type = type;
        self.text = text;
        
        
    }
    return  self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
