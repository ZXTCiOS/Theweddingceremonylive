//
//  feedbackVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "feedbackVC.h"
#import "WJGtextView.h"
@interface feedbackVC ()
@property (nonatomic,strong) WJGtextView *contentText;
@property (nonatomic,strong) UIButton *sendBtn;
@end

@implementation feedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户反馈";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    
    [self.view addSubview:self.contentText];
    [self.view addSubview:self.sendBtn];
}

#pragma mark - getters

-(WJGtextView *)contentText
{
    if(!_contentText)
    {
        _contentText = [[WJGtextView alloc] init];
        _contentText.frame = CGRectMake(0, 0, kScreenW, 200*HEIGHT_SCALE);
        _contentText.customPlaceholder = @"请留下宝贵的建议吧!";
    }
    return _contentText;
}


-(UIButton *)sendBtn
{
    if(!_sendBtn)
    {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setTitle:@"提交" forState:normal];
        [_sendBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
        
    }
    return _sendBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
