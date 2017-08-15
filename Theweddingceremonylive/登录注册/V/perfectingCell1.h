//
//  perfectingCell1.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "selectBtn.h"
@protocol mycellVdelegate <NSObject>
-(void)nanbtnClick:(UITableViewCell *)cell;
-(void)nvbtnClick:(UITableViewCell *)cell;

@end
@interface perfectingCell1 : UITableViewCell
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@property (nonatomic,strong) selectBtn *selbtn0;
@property (nonatomic,strong) selectBtn *selbtn1;
@end
