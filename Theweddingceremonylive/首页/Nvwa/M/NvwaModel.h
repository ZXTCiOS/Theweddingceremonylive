//
//  NvwaModel.h
//  Theweddingceremonylive
//
//  Created by apple on 17/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LieBiaoModel.h"
#import "NvwaHeaderModel.h"
#import "NvwaYugaoModel.h"
#import "WeddingLiveModel.h"

@interface NvwaModel : NSObject



@property (nonatomic, strong) NSMutableArray<NvwaYugaoModel *> *yugao;

@property (nonatomic, strong) NvwaHeaderModel *nvwa;

@property (nonatomic, strong) NSArray< LieBiaoModel *> *jmb;

@property (nonatomic, strong) WeddingLiveDataLiveDataModel *info;


@end
