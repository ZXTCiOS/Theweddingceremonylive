//
//  NvWaPinDaoVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "NvWaPinDaoVC.h"
#import "NvWaCell.h"
#import "NvWaTuiJianCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "LiebiaoCell.h"
#import "NvwaModel.h"
#import "NvwaHeaderView.h"


@interface NvWaPinDaoVC ()

@property (nonatomic, strong) NSMutableArray<NvwaYugaoModel *> *datalist;
@property (nonatomic, strong) NSArray<LieBiaoModel *> *liebiao;
@property (nonatomic, strong) NvwaHeaderModel *header;
@property (nonatomic, strong) NvwaHeaderView *headerView;
@end

@implementation NvWaPinDaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"女娲频道";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tag = 200;
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NvWaCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[NvWaTuiJianCell class] forCellReuseIdentifier:@"tuijian"];
    [self netWorking];
    [self configHeaderView];
    [self configHeaderView];
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self.tabBarController.tabBar setHidden:NO];
}

//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//}

- (void)configHeaderView{
    if (self.header) {
        [self.headerView.imgV sd_setImageWithURL:[NSURL URLWithString:self.header.nvwa_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
        self.headerView.title.text = self.header.nvwa_title;
        NSString *zhibo = self.header.nvwa_is_zb ? @"直播中" : @"未直播";
        self.headerView.isZhibo.text = zhibo;
    }
}



- (void)netWorking{
    
    MJWeakSelf
    [self.tableView addHeaderRefresh:^{
        [weakSelf headerRefresh];
    }];
    [self.tableView addFooterRefresh:^{
        [weakSelf footerRefresh];
    }];
    [self headerRefresh];
}
static NSInteger page = 1;
- (void)headerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    //
    [DNNetworking postWithURLString:post_nvwapindao parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NvwaModel *model = [NvwaModel parse:data];
            
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:model.yugao];
            self.liebiao = model.jmb;
            self.header = model.nvwa;
            page = 1;
            NvWaTuiJianCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [cell.tableV reloadData];
            [self.tableView reloadData];
            [self configHeaderView];
        } else {
            //NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
            [self.view showWarning:@"error"];
        }
        
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.tableView endHeaderRefresh];
    }];
}

- (void)footerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    page++;
    [DNNetworking postWithURLString:post_nvwapindao parameters:@{@"uid": uid, @"token": token, @"page": @(page)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NvwaModel *model = [NvwaModel parse:data];
            [self.datalist addObjectsFromArray:model.yugao];
            [self.tableView reloadData];
        } else {
            //NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
            [self.view showWarning:@"error"];
            page--;
        }
        
        [self.tableView endFooterRefresh];
    } failure:^(NSError *error) {
        page--;
        [self.view showWarning:@"网络错误"];
        [self.tableView endFooterRefresh];
    }];
}


#pragma mark tableveiw   delegate && datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag ==100) {
        return 1;
    } else {
    return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return self.liebiao.count;
    } else {
    return section ? self.datalist.count : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        LiebiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liebiao" forIndexPath:indexPath];
        NSString *time = [NSString stringWithFormat:@"%@", self.liebiao[indexPath.row].nvwa_post_time];
        cell.time.text = time;
        cell.desc.text = self.liebiao[indexPath.row].nvwa_post_title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
    
    switch (indexPath.section) {
        case 0:{
            NvWaTuiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tuijian" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tableV.tag = 100;
            cell.tableV.dataSource = self;
            cell.tableV.delegate = self;
            cell.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.tableV.tableFooterView = [UIView new];
            [cell.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([LiebiaoCell class]) bundle:nil] forCellReuseIdentifier:@"liebiao"];
            return cell;
        }
            break;
        case 1:{
            NvWaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            NSString *time = [NSString stringWithFormat:@"%@", self.datalist[indexPath.row].nvwa_yugao_addtime];
            NSLog(@"%@", time);
            cell.time.text = time;
            [cell.img sd_setImageWithURL:[NSURL URLWithString:self.datalist[indexPath.row].nvwa_yugao_img] placeholderImage:[UIImage imageNamed:@"16bi9"]];
            cell.desc.text = self.datalist[indexPath.row].nvwa_yugao_title;
            
            return cell;
        }
            break;
        default:
            break;
    }
    }
    return nil;
}

#pragma mark   头部视图

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return 0.001;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 100) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    UIView *grayV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 5)];
    grayV.backgroundColor = krgb(242, 242, 242, 1);
    [view addSubview:grayV];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 15, 15)];
    img.image = [UIImage imageNamed:section ?@"nwpd_jqjmyg" :@"nwpd_jcyg" ];
    [view addSubview:img];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(38, 20, 100, 15)];
    title.textColor = krgb(51, 51, 51, 1);
    title.text = !section ? @"精彩预告" : @"女娲频道";
    title.font = [UIFont systemFontOfSize:14];
    [view addSubview:title];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 200 && indexPath.section == 0) {
        return 200;
    }
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"section%ld, row%ld", indexPath.section, indexPath.row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray<NvwaYugaoModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<NvwaYugaoModel *> array];
    }
    return _datalist;
}

- (NvwaHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[NvwaHeaderView alloc] init];
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

@end
