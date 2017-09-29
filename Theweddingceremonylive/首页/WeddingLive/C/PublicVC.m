//
//  PublicVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "PublicVC.h"
#import "WeddingLiveModel.h"
#import "WeddingLivingCell.h"
#import "hengpingWatchVC.h"
#import "PortraitFullViewController.h"

@interface PublicVC ()

@property (nonatomic, strong) NSMutableArray<WeddingLiveDataLiveDataModel *> *datalist;

@end

@implementation PublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // type:  0, 公开  1, 加密
    NSString *title = [self.type isEqualToString:@"0"] ? @" 公开直播": @"加密直播";
    self.title = title;
    [self netWorking];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeddingLivingCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
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
    [DNNetworking postWithURLString:post_livelistmore parameters:@{@"uid": uid, @"token": token, @"type": self.type} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            
            [self.datalist removeAllObjects];
            NSArray<WeddingLiveDataLiveDataModel *> *arr = [WeddingLiveDataLiveDataModel parse:data];
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
    [DNNetworking postWithURLString:post_livelistmore parameters:@{@"uid": uid, @"token": token, @"page": @(page), @"type": self.type} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NSArray<WeddingLiveDataLiveDataModel *> *arr = [WeddingLiveDataLiveDataModel parse:data];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeddingLivingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WeddingLiveDataLiveDataModel *model = self.datalist[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.room_img.xd_URL placeholderImage:[UIImage imageNamed:@"hlzbfive"]];
    cell.titleL.text = model.room_name;
    cell.countL.text = model.pindao_renshu;
    cell.lockImg.hidden = !indexPath.section;
    if ([self.type isEqualToString:@"0"]) {
        cell.lockImg.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kScreenW - 24) / 7.0 * 4 + 45 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    WeddingLiveDataLiveDataModel *model = self.datalist[indexPath.row];
    
    if ([self.type isEqualToString:@"0"]) {
        if ([model.pindao_diretion isEqualToString:@"0"]) {
            // 横屏
            hengpingWatchVC *vc = [[hengpingWatchVC alloc] initWithChatroomID:model.roomid Url:model.tuilaliu meetingname:model.uid];
            vc.zhubo_name = model.username;
            vc.zhubo_img = model.picture;
            [self.navigationController pushViewController:vc animated:NO];
        } else {
            PortraitFullViewController *vc = [[PortraitFullViewController alloc] initWithChatroomID:model.roomid Url:model.tuilaliu meetingname:model.uid];
            vc.zhubo_name = model.username;
            vc.zhubo_img = model.picture;
            [self.navigationController pushViewController:vc animated:NO];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入密码";
        }];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *pwd = alert.textFields.firstObject;
            if ([pwd isEqual:model.order_password]) {
                
                if ([model.pindao_diretion isEqualToString:@"0"]) {
                    // 横屏
                    hengpingWatchVC *vc = [[hengpingWatchVC alloc] initWithChatroomID:model.roomid Url:model.tuilaliu meetingname:model.uid];
                    vc.zhubo_name = model.username;
                    vc.zhubo_img = model.picture;
                    [self.navigationController pushViewController:vc animated:NO];
                } else {
                    PortraitFullViewController *vc = [[PortraitFullViewController alloc] initWithChatroomID:model.roomid Url:model.tuilaliu meetingname:model.uid];
                    vc.zhubo_name = model.username;
                    vc.zhubo_img = model.picture;
                    [self.navigationController pushViewController:vc animated:NO];
                }
                
            } else {
                [self.view showWarning:@"密码错误, 请重新输入"];
            }
        }];
        UIAlertAction *ac1t = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:act];
        [alert addAction:ac1t];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}


- (NSMutableArray<WeddingLiveDataLiveDataModel *> *)datalist{
    if (!_datalist) {
        _datalist = [[NSMutableArray<WeddingLiveDataLiveDataModel *> alloc] init];
    }
    return _datalist;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
