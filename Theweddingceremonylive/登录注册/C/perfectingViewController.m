//
//  perfectingViewController.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "perfectingViewController.h"
#import "perfectingCell0.h"
#import "perfectingCell1.h"
#import "perfectingCell2.h"

@interface perfectingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *userImg;
@end

static NSString *perfectidentfid0 = @"perfectidentfid0";
static NSString *perfectidentfid1 = @"perfectidentfid1";
static NSString *perfectidentfid2 = @"perfectidentfid2";
static NSString *perfectidentfid3 = @"perfectidentfid3";

@implementation perfectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善个人资料";
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
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
    }
    return _table;
}

-(UIView *)headView
{
    if(!_headView)
    {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150*HEIGHT_SCALE)];
        [_headView addSubview:self.userImg];
    }
    return _headView;
}

-(UIImageView *)userImg
{
    if(!_userImg)
    {
        _userImg = [[UIImageView alloc] init];
        _userImg.frame = CGRectMake(kScreenW/2-40*WIDTH_SCALE, 25*HEIGHT_SCALE, 80*WIDTH_SCALE, 80*WIDTH_SCALE);
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.cornerRadius = 40*WIDTH_SCALE;
        _userImg.image = [UIImage imageNamed:@"userpic"];
    }
    return _userImg;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid0];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid0];
            cell.lab.text = @"昵称";
            cell.text.placeholder = @"请输入昵称";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        perfectingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid1];
        if (!cell) {
            cell = [[perfectingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        perfectingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid2];
        if (!cell) {
            cell = [[perfectingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid2];
            cell.lab.text = @"真实姓名";
            cell.text.placeholder = @"请输入真实姓名";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        perfectingCell2 *cell = [tableView dequeueReusableCellWithIdentifier:perfectidentfid3];
        if (!cell) {
            cell = [[perfectingCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perfectidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 110*HEIGHT_SCALE;
    }else
    {
        return 75*HEIGHT_SCALE;
    }
}
@end
