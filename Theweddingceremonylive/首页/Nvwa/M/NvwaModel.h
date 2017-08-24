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



@interface NvwaModel : NSObject



@property (nonatomic, strong) NSMutableArray<NvwaYugaoModel *> *yugao;

@property (nonatomic, strong) NvwaHeaderModel *nvwa;

@property (nonatomic, strong) NSArray< LieBiaoModel *> *jmb;






@end
