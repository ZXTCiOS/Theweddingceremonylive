//
//  BaseTableViewController.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface BaseTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //[XDFactory addBackItemForVC:self];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark 空数据视图 DataSource && delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptyImg"];        // 空数据图片
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    
    [scrollView beginHeaderRefresh];
    NSLog(@"empty image tapped");
}





-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"did receive memory warning");
}

@end