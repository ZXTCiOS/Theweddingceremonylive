//
//  shopdetalisCell2.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/9/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shopdetalisCell2.h"
#import "CLPlayerView.h"

@interface shopdetalisCell2()
@property (nonatomic,strong) CLPlayerView *playview;
@end

@implementation shopdetalisCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.playview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - getters


-(CLPlayerView *)playview
{
    if(!_playview)
    {
        _playview = [[CLPlayerView alloc] initWithFrame:CGRectMake(10*WIDTH_SCALE, 5*HEIGHT_SCALE, kScreenW-20*WIDTH_SCALE, 190*HEIGHT_SCALE)];
        //    //重复播放，默认不播放
        _playview.repeatPlay = YES;
        //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
        _playview.isLandscape = NO;
        //    //设置等比例全屏拉伸，多余部分会被剪切
        //    playerView.fillMode = ResizeAspectFill;
        //    //设置进度条背景颜色
        //    playerView.progressBackgroundColor = [UIColor purpleColor];
        //    //设置进度条缓冲颜色
        //    playerView.progressBufferColor = [UIColor redColor];
        //    //设置进度条播放完成颜色
        //    playerView.progressPlayFinishColor = [UIColor greenColor];
        //    //全屏是否隐藏状态栏
        //    playerView.fullStatusBarHidden = NO;
        //    //是否静音，默认NO
        //    playerView.mute = YES;
        //    //转子颜色
        //    playerView.strokeColor = [UIColor redColor];
        //视频地址
//        _playview.url = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14587093851044544c.mp4"];
        //播放
     

    }
    return _playview;
}

-(void)setdata:(NSDictionary *)dic
{
    NSString *shipin = [dic objectForKey:@"shipin"];
    
     _playview.url = [NSURL URLWithString:shipin];
    [_playview playVideo];
    //返回按钮点击事件回调
    [_playview backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        //查询是否是全屏状态
        NSLog(@"%d",_playview.isFullScreen);
    }];
    //播放完成回调
    [_playview endPlay:^{
        //销毁播放器
        //        [playerView destroyPlayer];
        //        playerView = nil;
        NSLog(@"播放完成");
    }];
}

@end

