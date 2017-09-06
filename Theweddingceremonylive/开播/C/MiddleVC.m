//
//  MiddleVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MiddleVC.h"
#import "midVC.h"
#import "RealVC.h"

#import "weddingcardVC.h"

@interface MiddleVC ()

@end

@implementation MiddleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"";
    
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isyuyue
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_isyuyue parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            midVC *vc = [[midVC alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
            
        }
        else if([[obj objectForKey:@"code"] intValue]==1001)
        {
            //有预约
            
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
    
}

-(void)isrenzheng
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userdefat objectForKey:user_uid];
    NSString *token = [userdefat objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token};
    [DNNetworking postWithURLString:post_is_renzheng parameters:para success:^(id obj) {
        NSString *msg = [obj objectForKey:@"msg"];
        [MBProgressHUD showSuccess:msg];
        if ([[obj objectForKey:@"code"] intValue]==996) {
                RealVC *vc = [[RealVC alloc] init];
                [self.navigationController pushViewController:vc animated:NO];
            
        }
        else if([[obj objectForKey:@"code"] intValue]==1000)
        {
            //已经认证
            [self isyuyue];
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    RealVC *vc = [[RealVC alloc] init];
//    [self.navigationController pushViewController:vc animated:NO];
    
    // 预约
    [self isyuyue];
    
    //认证
////    [self isrenzheng];
//    weddingcardVC *vc = [[weddingcardVC alloc] init];
//    vc.order_id = @"1";
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
