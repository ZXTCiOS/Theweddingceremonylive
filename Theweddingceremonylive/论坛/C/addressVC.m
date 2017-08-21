//
//  addressVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "addressVC.h"

@interface addressVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray *addressarray;
@end
static NSString *addressidentfid = @"addressidentfid";
@implementation addressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.table];
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
    }
    return _table;
}


-(NSArray *)addressarray
{
    if(!_addressarray)
    {
        _addressarray = @[@"北京",@"上海",@"天津",@"重庆",@"黑龙江",@"吉林",@"辽宁",@"内蒙古",@"河北",@"山西",@"山东",@"江苏",@"安徽",@"江西",@"浙江",@"福建",@"广东",@"广西",@"湖南",@"湖北",@"四川",@"云南",@"贵州",@"陕西",@"宁夏",@"甘肃",@"新疆",@"西藏",@"海南",@"台湾",@"香港",@"澳门"];
        
    }
    return _addressarray;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressidentfid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressidentfid];
    }
    cell.textLabel.text = self.addressarray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.returnvalueBlock) {
        NSString *address = self.addressarray[indexPath.row];
        self.returnvalueBlock(address);
    }
    [self.navigationController popViewControllerAnimated:YES];
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

//把传进来的block语句保存在本垒的实力变量returnValueBlock中
- (void)returnValue:(returnValueBlock)returnvalueBlock
{
    self.returnvalueBlock = returnvalueBlock;
}


@end
