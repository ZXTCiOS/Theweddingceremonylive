//
//  MainNaviBar.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MainNaviBar.h"

@interface MainNaviBar()

@property (weak, nonatomic) IBOutlet UIControl *mask;

@end

@implementation MainNaviBar


- (void)awakeFromNib{
    [super awakeFromNib];
    self.mask.layer.cornerRadius = 15;
    self.mask.layer.masksToBounds = YES;
    self.mask.backgroundColor = [UIColor whiteColor];
}

- (IBAction)search:(id)sender {
}



- (IBAction)saoma:(id)sender {
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
