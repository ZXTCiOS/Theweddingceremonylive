//
//  postingVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postingVC.h"
#import "postCell0.h"
#import "postCell1.h"


@interface postingVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *postidentfid0 = @"postidentfid0";
static NSString *postidentfid1 = @"postidentfid1";

@implementation postingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发帖";
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        postCell0 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid0];
        if (!cell) {
            cell = [[postCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid0];
        }
        cell.titletext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        postCell1 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid1];
        if (!cell) {
            cell = [[postCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid1];

            cell.imgView.tag = 202;
            cell.imgBtn.tag = 201;
            cell.textView.tag = 203;
        }
        cell.textView.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 200*HEIGHT_SCALE;
    }
    return 0.01f;
}

#pragma mark - 实现方法

#pragma mark - delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
