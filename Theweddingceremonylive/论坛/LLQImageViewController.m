//
//  LLQImageViewController.m
//  LLQImageView
//
//  Created by LLQ on 16/6/15.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "LLQImageViewController.h"
#import "UIImageView+WebCache.h"
#import "UIView+ViewController.h"

@interface LLQImageViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    CGRect _newRect;
}
@end

@implementation LLQImageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //转换坐标系
    //将item的位置转化到本视图上
    _newRect = [_item.superview convertRect:_item.frame toView:self.view];
    _item.frame = _newRect;
    [self.view addSubview:_item];
    
    [self loadScrollView];
}

//视图将要显示
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        
        _item.frame = self.view.frame;
        
    } completion:^(BOOL finished) {
        
        //点击的是哪一个图片，就偏移到哪个图片
        _scrollView.contentOffset = CGPointMake((self.view.bounds.size.width+10)*_item.index, 0);
        _index = _item.index;
        _scrollView.hidden = NO;
        
        _item.frame = _item.originFrame;
        [_imageView addSubview:_item];
        
    }];
    
}

//加载滑动视图
- (void)loadScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width+10, self.view.bounds.size.height)];
    _scrollView.contentSize = CGSizeMake((self.view.bounds.size.width+10)*_data.count, self.view.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.hidden = YES;
    _scrollView.delegate = self;
    
    for (int i = 0; i < _data.count; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width+10)*i, 0, self.view.bounds.size.width+10, self.view.bounds.size.height)];

        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        //图片水平自适应
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [imageV setImageWithURL:[NSURL URLWithString:_data[i]]];
        //允许用户点击事件
        imageV.userInteractionEnabled = YES;
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [imageV addGestureRecognizer:tap];
        
        [view addSubview:imageV];
        [_scrollView addSubview:view];
    }
    [self.view addSubview:_scrollView];
    
}

//滑动视图子视图点击事件
- (void)dismiss{
    
    //取到现在显示的单元格
    LLQImageItem *item = [_imageView viewWithTag:_index+1];
    
    //将item拿到最上层
    [item.superview bringSubviewToFront:item];
    //修改item的坐标，改为大图
    CGPoint point = [self.view convertPoint:CGPointZero toView:_imageView];
    item.frame = CGRectMake(point.x, point.y, self.view.frame.size.width, self.view.frame.size.height);
    
    //模态消失
    [self dismissViewControllerAnimated:NO completion:^{
        //动画
       [UIView animateWithDuration:0.5 animations:^{
           
           item.frame = item.originFrame;
           
       } completion:^(BOOL finished) {

       }];
        
    }];
    
    
    
    
}


#pragma mark------UIScorollViewDelegate

//将要结束滑动时调用
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    _index = targetContentOffset->x/(self.view.bounds.size.width+10);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
