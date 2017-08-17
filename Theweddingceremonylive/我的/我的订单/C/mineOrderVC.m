//
//  mineOrderVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineOrderVC.h"
#import "NinaPagerView.h"

@interface mineOrderVC ()
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@end

@implementation mineOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.ninaPagerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NinaParaArrays

- (NSArray *)ninaTitleArray {
    return @[
             @"待使用",
             @"历史",
             @"已完成"
             ];
}

- (NSArray *)ninaVCsArray {
    return @[
             @"orderVC0",
             @"orderVC1",
             @"orderVC2"
             ];
}

#pragma mark - LazyLoad

- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        _ninaPagerView.unSelectTitleColor = [UIColor whiteColor];
        CGRect pagerRect = CGRectMake(0, 0, kScreenW, kScreenH);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:vcsArray];
        _ninaPagerView.titleScale = 1;
        _ninaPagerView.unSelectTitleColor = [UIColor colorWithHexString:@"333333"];
        _ninaPagerView.selectTitleColor = [UIColor colorWithHexString:@"ed5e40"];
        _ninaPagerView.underlineColor = [UIColor colorWithHexString:@"ed5e40"];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
    }
    return _ninaPagerView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


@end
