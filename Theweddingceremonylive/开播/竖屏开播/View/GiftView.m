//
//  GiftView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "GiftView.h"
#import "GiftCell.h"



@interface GiftView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *alphaV;

@property (nonatomic, strong) NSArray<GiftModel *> *gift_tongyong;
@property (nonatomic, strong) NSArray<GiftModel *> *gift_zhufu;
@property (nonatomic, strong) NSArray<GiftModel *> *gift_dongfang;
@property (nonatomic, strong) NSArray<GiftModel *> *gift_miyue;

@end


@implementation GiftView

- (instancetype)initWithDirection:(screenDirection)direction{
    CGRect frame;
    if (direction == screenDirectionV) {
        frame = CGRectMake(0, kScreenH, kScreenW, 230);
    } else {
        frame = CGRectMake(0, kScreenH, kScreenW, 75);
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.direction = direction;
        [self alphaV];
        [self send];
        [self chongzhi];
        [self yuE];
        [self collectionView];
        
    }
    return self;
}

- (UIView *)alphaV{
    if (!_alphaV) {
        _alphaV = [[UIView alloc] init];
        [self addSubview:_alphaV];
        [_alphaV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _alphaV.backgroundColor = [UIColor whiteColor];
        _alphaV.alpha = 0.3;
    }
    return _alphaV;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout  = [UICollectionViewFlowLayout new];
        CGRect frame;
        if (self.direction == screenDirectionV){
            layout.itemSize = CGSizeMake(kScreenW/4, 75);
        } else {
            layout.itemSize = CGSizeMake(kScreenH/4, 75);
        }
        
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        if (self.direction == screenDirectionV) {
            frame = CGRectMake(0, 0, kScreenW, 160);
        } else {
            frame = CGRectMake(0, 0, kScreenW-100, 75);
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GiftCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIButton *)send{
    if (!_send) {
        _send = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_send];
        if (self.direction == screenDirectionV) {
            
            [_send mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(60, 25));
                make.right.equalTo(-10);
                make.bottom.equalTo(-15);
            }];
        } else {
            [_send mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(60, 25));
                make.bottom.equalTo(-5);
                make.right.equalTo(-10);
            }];
        }
        [_send setTitle:@"赠送" forState:UIControlStateNormal];
        [_send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_send setBackgroundColor:krgb(237, 94, 64, 1)];
        _send.titleLabel.font = [UIFont systemFontOfSize:15];
        _send.layer.cornerRadius = 12.5;
        _send.layer.masksToBounds = YES;
        
    }
    return _send;
}




- (UIButton *)chongzhi{
    if (!_chongzhi) {
        _chongzhi = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_chongzhi];
        if (self.direction == screenDirectionV) {
            [_chongzhi mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(10);
                make.centerY.equalTo(self.send.mas_centerY);
                make.size.equalTo(CGSizeMake(40, 15));
            }];
        } else {
            [_chongzhi mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-10);
                make.bottom.equalTo(self.send.mas_top).equalTo(-14);
                make.size.equalTo(CGSizeMake(40, 15));
            }];
        }
        [_chongzhi setTitle:@"充值>" forState: UIControlStateNormal];
        [_chongzhi setTitleColor:krgb(237, 94, 64, 1) forState:UIControlStateNormal];
        [_chongzhi setBackgroundColor:[UIColor clearColor]];
        _chongzhi.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _chongzhi;
}

// 个数  不要
- (UIButton *)number{
    if (!_number) {
        _number = [UIButton buttonWithType:UIButtonTypeSystem];
        if (self.direction == screenDirectionV) {
            
        } else {
            
        }
        [_number setTintColor:krgb(100, 100, 100, 1)];
        [_number setTitle:@"1" forState:UIControlStateNormal];
        [self addSubview:_number];
    }
    return _number;
}

- (UILabel *)yuE{
    if (!_yuE) {
        _yuE = [[UILabel alloc] init];
        [self addSubview:_yuE];
        if (self.direction == screenDirectionV) {
            [_yuE mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.centerY.equalTo(self.send.mas_centerY);
                make.size.equalTo(CGSizeMake(100, 20));
            }];
            _yuE.textAlignment = NSTextAlignmentLeft;
        } else {
            [_yuE mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.chongzhi.mas_centerY);
                make.right.equalTo(self.chongzhi.mas_left).equalTo(-5);
                make.size.equalTo(CGSizeMake(120, 20));
            }];
            _yuE.textAlignment = NSTextAlignmentRight;
        }
        
        _yuE.textColor = krgb(237, 94, 64, 1);
        _yuE.font = [UIFont systemFontOfSize:15];
        
    }
    return _yuE;
}

// 仅限竖屏  buyao
- (UIPageControl *)pageC{
    if (!_pageC) {
        
        [self addSubview:_pageC];
        
        _pageC.numberOfPages = 4;
        
    }
    return _pageC;
}



#pragma mark - collectionview delegate && datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.giftlist[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GiftModel *model = self.giftlist[indexPath.section][indexPath.row];
    
    cell.imageV.image = [YYImage imageNamed:model.name];
    cell.name.text = model.name;
    NSLog(@"%@", model.name);
    cell.price.text = [NSString stringWithFormat:@"¥%ld", model.price];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftCell *cell = (GiftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = krgb(237, 94, 64, 1);
    self.currentIndex = indexPath;
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftCell *cell = (GiftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
}


- (NSArray<NSArray *> *)giftlist{
    if (!_giftlist) {
        _giftlist = @[self.gift_tongyong, self.gift_zhufu, self.gift_dongfang, self.gift_miyue];
    }
    return _giftlist;
}

- (NSArray<GiftModel *> *)gift_tongyong{
    if (!_gift_tongyong) {
        GiftModel *model0 = [GiftModel giftWithGiftID:@"1" name:@"玫瑰花" picture:@"红玫瑰" price:1 animationType:giftAnimationTypeTop duration:3 audioName:@"none"];
        GiftModel *model1 = [GiftModel giftWithGiftID:@"2" name:@"百合花" picture:@"香水百合" price:2 animationType:giftAnimationTypeTop duration:3 audioName:@"none"];
        GiftModel *model2 = [GiftModel giftWithGiftID:@"3" name:@"鞭炮" picture:@"鞭炮" price:3 animationType:giftAnimationTypeStatic duration:8 audioName:@"鞭炮音效"];
        GiftModel *model3 = [GiftModel giftWithGiftID:@"4" name:@"萤火虫之舞" picture:@"萤火虫之舞" price:9 animationType:giftAnimationTypeStatic duration:5 audioName:@"萤火虫之舞"]; 
        GiftModel *model4 = [GiftModel giftWithGiftID:@"5" name:@"花瓣雨" picture:@"花瓣雨" price:9 animationType:giftAnimationTypeStatic duration:5 audioName:@"none"];
        GiftModel *model5 = [GiftModel giftWithGiftID:@"6" name:@"礼花筒" picture:@"礼花筒" price:9 animationType:giftAnimationTypeStatic duration:5 audioName:@"礼花筒音效"];
        GiftModel *model6 = [GiftModel giftWithGiftID:@"7" name:@"礼炮" picture:@"礼炮" price:9 animationType:giftAnimationTypeStatic duration:5 audioName:@"礼炮声效"];
        GiftModel *model7 = [GiftModel giftWithGiftID:@"8" name:@"舞狮" picture:@"舞狮" price:19 animationType:giftAnimationTypeStatic duration:8 audioName:@"舞狮音效"];
        
        _gift_tongyong = @[model0, model1, model2, model3, model4, model5, model6, model7];
    }
    return _gift_tongyong;
}

- (NSArray<GiftModel *> *)gift_zhufu{
    if (!_gift_zhufu) {
        
        GiftModel *model0 = [GiftModel giftWithGiftID:@"9" name:@"百年好合" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"烟火音效"];
        GiftModel *model1 = [GiftModel giftWithGiftID:@"10" name:@"永结同心" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"烟火音效"];
        GiftModel *model2 = [GiftModel giftWithGiftID:@"11" name:@"执手偕老" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"烟火音效"];
        GiftModel *model3 = [GiftModel giftWithGiftID:@"12" name:@"郎才女貌" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"none"];
        GiftModel *model4 = [GiftModel giftWithGiftID:@"13" name:@"花好月圆" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"烟火音效"];
        GiftModel *model5 = [GiftModel giftWithGiftID:@"14" name:@"佳偶天成" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:5 audioName:@"none"];
        GiftModel *model6 = [GiftModel giftWithGiftID:@"15" name:@"麒麟送子" picture:@"" price:18 animationType:giftAnimationTypeCircle duration:8 audioName:@"麒麟送子音效"];
        GiftModel *model7 = [GiftModel giftWithGiftID:@"16" name:@"龙凤呈祥" picture:@"" price:18 animationType:giftAnimationTypeCircle duration:8 audioName:@"龙凤呈祥音效"];
        
        _gift_zhufu = @[model0, model1, model2, model3, model4, model5, model6, model7];
    }
    return _gift_zhufu;
}
- (NSArray<GiftModel *> *)gift_dongfang{
    if (!_gift_dongfang) {
        GiftModel *model0 = [GiftModel giftWithGiftID:@"17" name:@"金币" picture:@"" price:19 animationType:giftAnimationTypeStatic duration:5 audioName:@"金币音效"];
        GiftModel *model1 = [GiftModel giftWithGiftID:@"18" name:@"金元宝" picture:@"" price:19 animationType:giftAnimationTypeStatic duration:5 audioName:@"金元宝音效"];
        GiftModel *model2 = [GiftModel giftWithGiftID:@"19" name:@"交杯酒" picture:@"" price:19 animationType:giftAnimationTypeCircle duration:2 audioName:@"交杯酒音效"];
        GiftModel *model3 = [GiftModel giftWithGiftID:@"20" name:@"奉旨闹洞房" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:2 audioName:@"奉旨闹洞房音效"];
//        GiftModel *model4 = [GiftModel giftWithGiftID:@"21" name:@"摇钱树" picture:@"" price:28 animationType:giftAnimationTypeTop duration:2 audioName:@"none"];
//        GiftModel *model5 = [GiftModel giftWithGiftID:@"22" name:@"交杯酒" picture:@"" price:28 animationType:giftAnimationTypeTop duration:2 audioName:@"none"];
//        GiftModel *model6 = [GiftModel giftWithGiftID:@"23" name:@"麒麟送子" picture:@"" price:19 animationType:giftAnimationTypeTop duration:2 audioName:@"none"];
//        GiftModel *model7 = [GiftModel giftWithGiftID:@"24" name:@"龙凤呈祥" picture:@"" price:19 animationType:giftAnimationTypeTop duration:2 audioName:@"none"];
        _gift_dongfang = @[model0, model1, model2, model3];//, model4, model5, model6, model7];
    }
    return _gift_dongfang;
}

- (NSArray<GiftModel *> *)gift_miyue{
    if (!_gift_miyue) {
        GiftModel *model0 = [GiftModel giftWithGiftID:@"21" name:@"巴厘岛" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model1 = [GiftModel giftWithGiftID:@"22" name:@"马尔代夫" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model2 = [GiftModel giftWithGiftID:@"23" name:@"夏威夷" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model3 = [GiftModel giftWithGiftID:@"24" name:@"爱琴海" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model4 = [GiftModel giftWithGiftID:@"25" name:@"巴黎" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model5 = [GiftModel giftWithGiftID:@"26" name:@"瑞士" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model6 = [GiftModel giftWithGiftID:@"27" name:@"威尼斯" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        GiftModel *model7 = [GiftModel giftWithGiftID:@"28" name:@"罗马" picture:@"" price:28 animationType:giftAnimationTypeCircle duration:7 audioName:@"飞机音效"];
        
        _gift_miyue = @[model0, model1, model2, model3, model4, model5, model6, model7];
    }
    return _gift_miyue;
}






@end
