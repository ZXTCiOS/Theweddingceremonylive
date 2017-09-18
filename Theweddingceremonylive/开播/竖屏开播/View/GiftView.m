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

@property (nonatomic, strong) NSArray *tongyong;
@property (nonatomic, strong) NSArray *zhufu;
@property (nonatomic, strong) NSArray *dongfang;
@property (nonatomic, strong) NSArray *miyue;

@property (nonatomic, strong) UIView *alphaV;


@property (nonatomic, strong) NSArray *tongyongimg;
@property (nonatomic, strong) NSArray *zhufuimg;
@property (nonatomic, strong) NSArray *dongfangimg;
@property (nonatomic, strong) NSArray *miyueimg;


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
        self.pricearr = @[self.tongyong, self.zhufu, self.dongfang, self.miyue];
        self.imagearr = @[self.tongyongimg, self.zhufuimg, self.dongfangimg, self.miyueimg];
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
        layout.itemSize = CGSizeMake(kScreenW/4, 75);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        if (self.direction == screenDirectionV) {
            frame = CGRectMake(0, 0, kScreenW, 160);
        } else {
            frame = CGRectMake(0, 0, kScreenW, 75);
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
    return self.imagearr[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imagearr[indexPath.section][indexPath.row]];
    cell.price.text = [NSString stringWithFormat:@"¥%@", self.pricearr[indexPath.section][indexPath.row]];
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






- (NSArray *)tongyong{
    if (!_tongyong) {
        _tongyong = @[@"1", @"2", @"3", @"6", @"8", @"9"];
    }
    return _tongyong;
}

- (NSArray *)zhufu{
    if (!_zhufu) {
        _zhufu = @[@"9", @"9", @"9", @"9", @"9", @"9",  @"19", @"19"];
    }
    return _zhufu;
}

- (NSArray *)dongfang{
    if (!_dongfang) {
        _dongfang = @[@"9", @"9", @"19", @"19", @"28", @"28"];
    }
    return _dongfang;
}

- (NSArray *)miyue{
    if (!_miyue) {
        _miyue = @[@"28", @"28", @"28", @"28", @"28", @"28", @"28", @"28"];
    }
    return _miyue;
}

- (NSArray *)tongyongimg{
    if (!_tongyongimg) {
        _tongyongimg = @[@"1", @"2", @"3", @"6", @"8", @"9"];
    }
    return _tongyongimg;
}

- (NSArray *)zhufuimg{
    if (!_zhufuimg) {
        _zhufuimg = @[@"9", @"9", @"9", @"9", @"9", @"9",  @"19", @"19"];
    }
    return _zhufuimg;
}

- (NSArray *)dongfangimg{
    if (!_dongfangimg) {
        _dongfangimg= @[@"9", @"9", @"19", @"19", @"28", @"28"];
    }
    return _dongfangimg;
}

- (NSArray *)miyueimg{
    if (!_miyueimg) {
        _miyueimg = @[@"28", @"28", @"28", @"28", @"28", @"28", @"28", @"28"];
    }
    return _miyueimg;
}




@end
