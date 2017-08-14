//
//  LiveVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveVC.h"
#import "ViewController.h"
#import "LiveVideoCell.h"
#import "LiveVideoModel.h"
#import "WMPlayer.h"

@interface LiveVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<LiveVideoModel *> *datalist;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSIndexPath *currentIndex;

@property (nonatomic, strong) WMPlayer *player;

@end

@implementation LiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self networking];
    [self tableView];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"333333"];
    self.tabBarController.tabBar.alpha = 0.1f;
    //设置为透明
    self.tabBarController.tabBar.translucent = YES;
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma networking

- (void)networking{
    MJWeakSelf
    self.page = 0;
    [self.tableView addHeaderRefresh:^{
        [weakSelf headerRefresh];
    }];
    [self.tableView addFooterRefresh:^{
        [weakSelf footerRefresh];
    }];
    [self headerRefresh];
}

- (void)headerRefresh{
    self.page = 0;
    [DNNetworking getWithURLString:get_video success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSArray<LiveVideoModel *> *arr = [NSArray modelArrayWithClass:[LiveVideoModel class] json:[obj valueForKey:@"data"]];
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            NSString *msg = [obj valueForKey:@"message"];
            [self.view showWarning:msg];
        }
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.tableView endHeaderRefresh];
    }];
    
}

- (void)footerRefresh{
    NSString *page = [NSString stringWithFormat:@"%ld", (long)self.page];
    [DNNetworking getWithURLString:get_video parameters:@{@"page": page} success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray<LiveVideoModel *> *arr = [NSArray modelArrayWithClass:[LiveVideoModel class] json:[obj valueForKey:@"data"]];
            [self.datalist addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            NSString *msg = [obj valueForKey:@"message"];
            [self.view showWarning:msg];
        }
        [self.tableView endFooterRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.tableView endFooterRefresh];
    }];
}


#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.datalist[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return
    [UIScreen mainScreen].bounds.size.height;
}
#pragma mark UITableView Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger page = (int)(scrollView.contentOffset.y / kScreenH + 0.5);        // 四舍五入取整
    self.currentIndex = [NSIndexPath indexPathForRow:page inSection:0];
    
}



#pragma mark lazy load

- (NSMutableArray<LiveVideoModel *> *)datalist{
    if (!_datalist ) {
        _datalist = [[NSMutableArray<LiveVideoModel *> alloc] init];
    }
    return _datalist;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, kScreenW, kScreenH);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.pagingEnabled = YES;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveVideoCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.alpha = 1;
    //设置为透明
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"ed5e40"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
