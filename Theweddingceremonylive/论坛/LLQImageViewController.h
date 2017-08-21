//
//  LLQImageViewController.h
//  LLQImageView
//
//  Created by LLQ on 16/6/15.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLQImageView.h"

@interface LLQImageViewController : UIViewController

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)LLQImageItem *item;
@property(nonatomic,strong)NSArray *data;

@property(nonatomic,strong)LLQImageView *imageView;

@end
