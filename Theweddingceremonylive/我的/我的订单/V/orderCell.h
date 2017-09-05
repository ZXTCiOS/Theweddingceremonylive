//
//  orderCell.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class orderModel;
@protocol mysubmitVdelegate <NSObject>
-(void)submitbtnClick:(UITableViewCell *)cell;
@end

@interface orderCell : UITableViewCell
@property(assign,nonatomic)id<mysubmitVdelegate>delegate;
-(void)setdata:(orderModel *)model;
@end
