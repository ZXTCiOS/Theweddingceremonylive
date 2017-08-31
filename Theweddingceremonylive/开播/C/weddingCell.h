//
//  weddingCell.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class weddinglistModel;

@protocol myweddingVdelegate <NSObject>
-(void)choosebtnClick:(UITableViewCell *)cell;
@end


@interface weddingCell : UITableViewCell
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) UILabel *contentlab;
@property(assign,nonatomic)id<myweddingVdelegate>delegate;
-(void)setdata:(weddinglistModel *)model;
@end
