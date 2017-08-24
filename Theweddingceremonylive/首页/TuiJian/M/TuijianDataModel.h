//
//  TuijianDataModel.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuiJianModel.h"

@class TuiJDataModel, TuiJjianLunboModel;
@interface TuijianDataModel : NSObject


@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) TuiJDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end

@interface TuiJDataModel : NSObject

@property (nonatomic, strong) NSArray<TuiJjianLunboModel *> *lunbo;

@property (nonatomic, strong) NSArray<TuiJianModel *> *data;


@end

@interface TuiJjianLunboModel : NSObject

@property (nonatomic, assign) NSInteger ident;

@property (nonatomic, copy) NSString *title1;

@property (nonatomic, copy) NSString *linkurl;

@property (nonatomic, copy) NSString *picurl;

@end
