//
//  BBSVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BBSVC.h"
#import "hotVC.h"
#import "qualityVC.h"
#import "localVC.h"
#import "LKSegmentController.h"

@interface BBSVC ()
@property (nonatomic,strong) LKSegmentController *segmentBarVC;

@end

@implementation BBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.navigationController.navigationBar.topItem.title = @"BBS";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
    
    
    LKSegmentController *segmentBarVc = [[LKSegmentController alloc] init];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVC = segmentBarVc;
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 250, 35);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    self.segmentBarVC.contentViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.segmentBarVC.view];
    hotVC *vc1 = [[hotVC alloc] init];
    qualityVC *vc2 = [[qualityVC alloc] init];
    localVC *vc3 = [[localVC alloc] init];
    [self.segmentBarVC setUpWithItems:@[@"热点", @"精品", @"本地"] childViewControllers:@[vc1, vc2, vc3]];
    [self.segmentBarVC.segmentBar segmentBarStyle:^(LKSegmentBarStyle *barStyle) {
        barStyle.backgroundColor = [UIColor clearColor];
        barStyle.indicatorExtraW = 2;
        barStyle.indicatorHeight = 2;
        barStyle.backgroundColor = [UIColor whiteColor];
        barStyle.itemNormalColor = [UIColor colorWithHexString:@"333333"];
        barStyle.itemSelectColor = [UIColor colorWithHexString:@"ed5e40"];
        barStyle.indicatorColor = [UIColor colorWithHexString:@"ed5e40"];
    }];

    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    tag.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tag];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
