//
//  predeterminedVC0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "predeterminedVC0.h"
#import "predetermindCell.h"
#import "predeterheadView0.h"

@interface predeterminedVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) predeterheadView0 *headView;
@end

static NSString *predeterminedidentfid0 = @"predeterminedidentfid0";

@implementation predeterminedVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    
    self.title = @"预定房间";

    
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
    self.table.tableFooterView = [UIView new];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

-(predeterheadView0 *)headView
{
    if(!_headView)
    {
        _headView = [[predeterheadView0 alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 300)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    predetermindCell *cell = [tableView dequeueReusableCellWithIdentifier:predeterminedidentfid0];
    cell = [[predetermindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:predeterminedidentfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.predetext.placeholder = @"输入推荐码";

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    NSLog(@"UIDatePicker:%@", datePicker.date);
}


-(void)rightAction
{
    
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
