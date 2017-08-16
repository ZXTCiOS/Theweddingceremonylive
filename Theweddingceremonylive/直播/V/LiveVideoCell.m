//
//  LiveVideoCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveVideoCell.h"


@interface LiveVideoCell ()<WMPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *list;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIImageView *pause;

@end

@implementation LiveVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self player];
}



- (void)setModel:(LiveVideoModel *)model{
    _model = model;
    
    self.pause.hidden = YES;
    self.title.text = self.model.video_title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[self.model.video_time integerValue]];
    NSString *time = [formatter stringFromDate:date];
    self.time.text = time;
    
    self.desc.text = self.model.video_desc;
    [self.share removeAllTargets];
    [self.list removeAllTargets];
    [self.share bk_addEventHandler:^(id sender) {
        
        NSLog(@"share clicked");
    } forControlEvents:UIControlEventTouchUpInside];
    [self.list bk_addEventHandler:^(id sender) {
        
        NSLog(@"list clicked");
    } forControlEvents:UIControlEventTouchUpInside];
    self.player.URLString = self.model.video_url;
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.video_url]];
    self.player.currentItem = item;
    [_player play];
    //[_player pause];
}




- (WMPlayer *)player{
    if (!_player) {
        _player = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _player.topView.hidden = YES;
        _player.bottomView.hidden = YES;
        _player.delegate = self;
        [self.contentView insertSubview:_player belowSubview:self.bgview];
    }
    return _player;
}

#pragma mark wmplayer delegate

- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    switch (wmplayer.state) {
        case WMPlayerStatePlaying:
            [wmplayer pause];
            self.pause.hidden = NO;
            break;
        case WMPlayerStatePause:
            [wmplayer play];
            self.pause.hidden = YES;
            break;
        case WMPlayerStateStopped:
            [wmplayer play];
            self.pause.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    [wmplayer.player seekToTime:CMTimeMake(0, 1)];
    [wmplayer play];
    [wmplayer.player play];
    wmplayer.state = WMPlayerStatePlaying;
}

- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    [wmplayer play];
}

- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    [wmplayer play];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
