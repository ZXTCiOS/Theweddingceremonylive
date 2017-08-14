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


@interface LiveVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<LiveVideoModel *> *datalist;

@property (nonatomic, assign) NSInteger page;

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
    [DNNetworking getWithURLString:@"" success:^(id obj) {
        NSString *code = [obj valueForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSArray<LiveVideoModel *> *arr = [NSArray modelArrayWithClass:[LiveVideoModel class] json:[obj valueForKey:@"data"]];
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:arr];
        }else{
            
        }
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        
        [self.tableView endHeaderRefresh];
    }];
    
}

- (void)footerRefresh{
    [DNNetworking getWithURLString:@"" parameters:@{@"page": @(self.page)} success:^(id obj) {
        NSString *code = [obj valueForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSArray<LiveVideoModel *> *arr = [NSArray modelArrayWithClass:[LiveVideoModel class] json:[obj valueForKey:@"data"]];
            [self.datalist addObjectsFromArray:arr];
        }else{
            
        }
        [self.tableView endFooterRefresh];
    } failure:^(NSError *error) {
        
        [self.tableView endFooterRefresh];
    }];
}


#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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

/*
    AVPlayerStatusUnknown,
    AVPlayerStatusReadyToPlay,
	AVPlayerStatusFailed
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //LiveVideoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.player.status
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(LiveVideoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark lazy load

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
