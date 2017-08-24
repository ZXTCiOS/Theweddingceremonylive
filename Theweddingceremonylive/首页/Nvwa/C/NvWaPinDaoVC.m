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


@interface NvWaPinDaoVC ()

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

- (void)headerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    //
    [DNNetworking postWithURLString:post_nvwapindao parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            
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
        return 10;
    } else {
    return section ? 6 : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        LiebiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liebiao" forIndexPath:indexPath];
        cell.time.text = @"10:22";
        cell.desc.text = @"这个世界已经疯了";
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
            
            cell.time.text = @"123456789";
            //
            cell.desc.text = @"description";
            
            return cell;
        }
            break;
        default:
            break;
    }
    }
    return nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
