//
//  PortraitFullMaskView.m
//  直播
//
//  Created by apple on 17/8/29.
//  Copyright © 2017年 xudogn. All rights reserved.
//

#import "PortraitFullMaskView.h"

@interface PortraitFullMaskView ()

@property (weak, nonatomic) IBOutlet UIControl *info;


@end


@implementation PortraitFullMaskView



- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.user_img.layer.cornerRadius = 13;
    self.user_img.layer.masksToBounds = YES;
    self.info.layer.cornerRadius = 13;
    self.info.layer.masksToBounds = YES;
    
    
}










#pragma mark - 底部 5个 button

- (IBAction)sendMsg:(id)sender {
    !_first ?: _first();
}


- (IBAction)second:(id)sender {
    !_second ?: _second();
}


- (IBAction)third:(id)sender {
    !_third ?: _third();
}


- (IBAction)forth:(id)sender {
    !_fourth ?: _fourth();
}


- (IBAction)fifth:(id)sender {
    !_fifth ?: _fifth();
}


/**
 点击头像

 @param sender btn
 */
- (IBAction)userInfo:(id)sender {
    
}









@end
