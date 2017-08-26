//
//  SearchResultVC.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseCollectionViewController.h"



typedef NS_ENUM(NSUInteger, SearchType) {
    SearchTypeAll,
    SearchTypeUser,
    SearchTypeLive,
    SearchTypeVideo,
    SearchTypeShop
};

@interface SearchResultVC : BaseCollectionViewController




- (instancetype)initWithSearchType:(SearchType) type text:(NSString *) text;

@end
