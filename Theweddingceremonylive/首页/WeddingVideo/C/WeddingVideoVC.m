//
//  WeddingVideoVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "WeddingVideoVC.h"
#import "WeddingVideoCell.h"
#import "WeddingVideoModel.h"
#import "SearchViewController.h"


@interface WeddingVideoVC ()

@property (nonatomic, strong) NSMutableArray<WeddingVideoModel *> *datalist;


@end

@implementation WeddingVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"婚礼视频";
    [self netWorking];
    [XDFactory addSearchItemForVC:self clickedHandler:^{
        SearchViewController *vc = [[SearchViewController alloc] init];
        [vc.navigationController pushViewController:vc animated:YES];
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingVideoCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    [DNNetworking postWithURLString:post_weddingvideo parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            
            [self.datalist removeAllObjects];
            NSArray<WeddingVideoModel *> *arr = [WeddingVideoModel parse:data];
            [self.datalist addObjectsFromArray:arr];
            [self.tableView reloadData];
            
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
    [DNNetworking postWithURLString:post_weddingvideo parameters:@{@"uid": uid, @"token": token, @"page": @(page)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NSArray<WeddingVideoModel *> *arr = [WeddingVideoModel parse:data];
            [self.datalist addObjectsFromArray:arr];
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


#pragma mark tableview  delegate && datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeddingVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WeddingVideoModel *model = self.datalist[indexPath.row];
    cell.title.text = model.video_title;
    if ([model.video_point integerValue] > 999) {
        model.video_point = @"999+";
    }
    cell.numberL.text = model.video_point;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.video_img] placeholderImage:[UIImage imageNamed:@""]];
    NSString *islike = model.is_point ? @"hlsp_zan_s": @"hlsp_zan";
    [cell.btn_like setImage:[UIImage imageNamed:islike] forState:UIControlStateNormal];
    [cell.btn_like removeAllTargets];
    [cell.btn_share removeAllTargets];
    [cell.btn_share bk_addEventHandler:^(id sender) {
        
        
        NSLog(@"分享");
    } forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_like bk_addEventHandler:^(id sender) {
        
        
        NSLog(@"点赞");
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld", indexPath.row);
}






















- (NSMutableArray<WeddingVideoModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<WeddingVideoModel *> array];
    }
    return _datalist;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
