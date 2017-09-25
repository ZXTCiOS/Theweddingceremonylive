//
//  SendRedBagView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "SendRedBagView.h"



@interface SendRedBagView ()

@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIView *moneybg;
@property (nonatomic, strong) UIView *numberbg;
@property (nonatomic, strong) UIView *koulingbg;
@property (nonatomic, strong) UIImageView *imgV;

@end

@implementation SendRedBagView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.sendBtn.layer.cornerRadius = 18;
    self.sendBtn.layer.masksToBounds = YES;
    self.isnormal = YES;
    
}



- (IBAction)normalset:(UIButton *)sender {
    sender.enabled = NO;
    self.random.enabled = YES;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.random setTitleColor:krgb(182, 59, 34, 1) forState:UIControlStateNormal];
    self.isnormal = YES;
}


- (IBAction)randomset:(UIButton *)sender {
    
    sender.enabled = NO;
    self.normal.enabled = YES;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.normal setTitleColor:krgb(182, 59, 34, 1) forState:UIControlStateNormal];
    self.isnormal = NO;
}
















@end
