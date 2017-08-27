//
//  WKWedViewController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "WKWedViewController.h"
#import <WebKit/WebKit.h>

@interface WKWedViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webV;

@property (nonatomic, strong) UIWebView *web;

@end

@implementation WKWedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        self.navigationItem.title = self.titl;
    }
    
    self.webV = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webV];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString: @"https://www.baidu.com"]];
    [self.webV loadRequest: req];
    self.webV.allowsBackForwardNavigationGestures = YES;
    
    MJWeakSelf
    [self.webV.scrollView addHeaderRefresh:^{
        [weakSelf.webV reload];
        [weakSelf.webV.scrollView endHeaderRefresh];
    }];
    [XDFactory addBackItemForVC:self];
    
}







- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (instancetype)initWithTitle:(NSString *)title Url:(NSURL *)url{
    self = [super init];
    if (self) {
        self.titl = title;
        self.url = url;
    }
    return self;
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
