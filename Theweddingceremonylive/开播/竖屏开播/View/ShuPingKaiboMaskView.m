//
//  ShuPingKaiboMaskView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ShuPingKaiboMaskView.h"

@interface ShuPingKaiboMaskView ()

@property (weak, nonatomic) IBOutlet UIView *iconMask;



@end


@implementation ShuPingKaiboMaskView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.iconMask.layer.cornerRadius = 25;
    self.iconMask.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
    
    
    
    
    
}

@end
