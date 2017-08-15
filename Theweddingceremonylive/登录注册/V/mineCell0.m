//
//  mineCell0.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell0.h"

@interface mineCell0()

@end

@implementation mineCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {

        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
}
@end
