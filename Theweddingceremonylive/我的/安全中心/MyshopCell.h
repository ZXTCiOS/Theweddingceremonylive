//
//  MyshopCell.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myshopModel;
@protocol mysubmitVdelegate <NSObject>
-(void)submitbtnClick:(UICollectionViewCell *)cell;
@end
@interface MyshopCell : UICollectionViewCell
@property(assign,nonatomic)id<mysubmitVdelegate>delegate;
-(void)setdata:(myshopModel *)model;
@end
