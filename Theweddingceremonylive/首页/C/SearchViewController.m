//
//  SearchViewController.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultUserVC.h"


@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate>



@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSDictionary *list;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //self.searchController.searchBar.showsScopeBar = YES;
    //self.searchController.searchBar.showsBookmarkButton = YES;
    self.searchController.searchBar.showsCancelButton = YES;
    for(id sousuo in [self.searchController.searchBar subviews])
    {
        for (id zz in [sousuo subviews])
        {
            if([zz isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)zz;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.searchController.searchBar.showsCancelButton = YES;
                [btn removeAllTargets];
                [btn bk_addEventHandler:^(id sender) {
                    [self.navigationController popViewControllerAnimated:YES];
                } forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    
    
}


//#pragma mark - tabbar
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.tabBarController.tabBar setHidden:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.tabBarController.tabBar setHidden:NO];
//}




#pragma mark tableview   delegate, datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.searchController.searchBar.text isEqualToString:@""] ? 0 : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    if (!self.list) return cell;
    NSString *count;
    NSString *name;
    switch (indexPath.row) {
        case 0:
            count = [NSString stringWithFormat:@"%@", self.list[@"users"]];
            name = @"用户/主播";
            break;
        case 1:
            count = [NSString stringWithFormat:@"%@", self.list[@"rooms"]];
            name = @"婚礼直播";
            break;
        case 2:
            count = [NSString stringWithFormat:@"%@", self.list[@"shipin"]];
            name = @"婚礼视频";
            break;
        case 3:
            count = [NSString stringWithFormat:@"%@", self.list[@"businnb"]];
            name = @"商家";
            break;
        default:
            break;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"搜索结果共%@个", count];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{//用户
            SearchResultUserVC *vc = [[SearchResultUserVC alloc] initWithSearchtext:self.searchController.searchBar.text];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            SearchResultVC *vc = [[SearchResultVC alloc] initWithSearchType:indexPath.row + 1 text:self.searchController.searchBar.text];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.searchController.searchBar.hidden = NO;
    [self.searchController.searchBar endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController.navigationBar setHidden:NO];
    self.searchController.searchBar.hidden = YES;
    [self.searchController.searchBar endEditing:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark searchVC resultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    self.searchController.searchBar.showsCancelButton = YES;
    for(id sousuo in [self.searchController.searchBar subviews])
    {
        for (id zz in [sousuo subviews])
        {
            if([zz isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)zz;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.searchController.searchBar.showsCancelButton = YES;
                [btn removeAllTargets];
                [btn bk_addEventHandler:^(id sender) {
                    [self.navigationController popViewControllerAnimated:YES];
                } forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    NSString *text = searchController.searchBar.text;
    if ([text isEqualToString:@""]) {
        [self.tableView reloadData];
        return;
    }
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    self.searchController.searchBar.showsCancelButton = NO;
    [DNNetworking postWithURLString:post_search parameters:@{@"key": text, @"type": @(0), @"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            self.list = [obj valueForKey:@"data"];
            [self.tableView reloadData];
        } else {
            //NSString *message = [NSString stringWithFormat:@"%@", [obj valueForKey:@"message"]];
            //[self.view showWarning:message];
        }
        
    } failure:^(NSError *error) {
        //[self.view showWarning:@"网络错误"];
    }];
    
    
}



- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder = @"请输入搜索内容";
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
        self.tableView.tableHeaderView = _searchController.searchBar;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        self.searchController.dimsBackgroundDuringPresentation = NO;
        self.searchController.obscuresBackgroundDuringPresentation = NO;
        
    }
    return _searchController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
