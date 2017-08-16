//
//  modifyCell.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mysubmitVdelegate <NSObject>
-(void)submitbtnClick:(UITableViewCell *)cell;
@end
@interface modifyCell : UITableViewCell
@property(assign,nonatomic)id<mysubmitVdelegate>delegate;
@end
