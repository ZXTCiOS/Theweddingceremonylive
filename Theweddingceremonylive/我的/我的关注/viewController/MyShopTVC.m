//
//  MyShopTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyShopTVC.h"
#import "MyshopCell.h"
#import "myshopModel.h"
#import "shopdetalisVC.h"

@interface MyShopTVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,mysubmitVdelegate>
@property (strong,nonatomic) UICollectionView *myCollectionV;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *indentify =  @"indentify";

@implementation MyShopTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的商家";
    
    [self addTheCollectionView];
    self.dataSource = [NSMutableArray array];
    [self loadtata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadtata
{
    NSUserDefaults *userefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userefat objectForKey:user_uid];
    NSString *token = [userefat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_guanzhu parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSArray *data = [obj objectForKey:@"data"];
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = [data objectAtIndex:i];
                myshopModel *model = [[myshopModel alloc] init];
                model.shopid = [dic objectForKey:@"id"];
                model.name = [dic objectForKey:@"name"];
                model.picurl = [dic objectForKey:@"picurl"];
                [self.dataSource addObject:model];
            }
        }
        else
        {
            NSString *msg = [obj objectForKey:@"msg"];
            [MBProgressHUD showSuccess:msg toView:self.view];
        }
        
        [self.myCollectionV reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络" toView:self.view];
    }];
}

//创建视图

-(void)addTheCollectionView{
    
    //=======================1===========================
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //格子的大小 (长，高)
    flowL.itemSize = CGSizeMake(150*WIDTH_SCALE, 130*HEIGHT_SCALE);
    //横向最小距离
    flowL.minimumInteritemSpacing = 1.f;
    //    flowL.minimumLineSpacing=60.f;//代表的是纵向的空间间隔
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowL.sectionInset = UIEdgeInsetsMake(16*HEIGHT_SCALE, 24*WIDTH_SCALE, 24*HEIGHT_SCALE, 24*WIDTH_SCALE);
    //创建一个UICollectionView
    _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -8, kScreenW, kScreenH) collectionViewLayout:flowL];
    //设置代理为当前控制器
    _myCollectionV.backgroundColor = [UIColor whiteColor];
    _myCollectionV.delegate = self;
    _myCollectionV.dataSource = self;
    
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.myCollectionV addGestureRecognizer:TapGestureTecognizer];
    
    [_myCollectionV registerClass:[MyshopCell class] forCellWithReuseIdentifier:indentify];
    
    //添加视图
    [self.view addSubview:_myCollectionV];
    
}

#pragma mark --UICollectionView dataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化每个单元格
    MyshopCell *cell = (MyshopCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.delegate = self;
    [cell setdata:self.dataSource[indexPath.item]];
    //给单元格上的元素赋值
//    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    shopdetalisVC *vc = [[shopdetalisVC alloc] init];
    myshopModel *model = self.dataSource[indexPath.row];
    vc.businid = model.shopid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)submitbtnClick:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [self.myCollectionV indexPathForCell:cell];
    NSLog(@"index------%ld",(long)index.item);
}

-(void)keyboardHide
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
@end
