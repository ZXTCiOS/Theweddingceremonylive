//
//  postCell1.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGtextView.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
@interface postCell1 : UITableViewCell
@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) UIButton *submitBtn;


@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;

@end
