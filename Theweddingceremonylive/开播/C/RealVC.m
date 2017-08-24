//
//  RealVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "RealVC.h"

@interface RealVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;

@end

@implementation RealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

-(void)backAction
{
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
