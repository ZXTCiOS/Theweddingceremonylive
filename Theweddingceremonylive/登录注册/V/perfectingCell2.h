//
//  perfectingCell2.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myfinishdelegate <NSObject>
-(void)finishbtnClick:(UITableViewCell *)cell;
@end
@interface perfectingCell2 : UITableViewCell
@property(assign,nonatomic)id<myfinishdelegate>delegate;
@end
