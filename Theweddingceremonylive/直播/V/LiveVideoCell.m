//
//  LiveVideoCell.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveVideoCell.h"

@implementation LiveVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self player];
}



- (AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.url]];
        _player = [AVPlayer playerWithPlayerItem:item];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = [UIScreen mainScreen].bounds;
        [self.layer addSublayer:layer];
        
    }
    return _player;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
