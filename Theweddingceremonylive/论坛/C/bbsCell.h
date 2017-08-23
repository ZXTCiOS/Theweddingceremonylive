//
//  bbsCell.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class bbsModel;

@protocol mybbsVdelegate <NSObject>
-(void)bbspointbtnClick:(UITableViewCell *)cell;
@end

@interface bbsCell : UITableViewCell
-(void)setdata:(bbsModel *)model;
@property(assign,nonatomic)id<mybbsVdelegate>delegate;
@end
