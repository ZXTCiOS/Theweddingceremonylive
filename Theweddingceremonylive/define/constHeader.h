//
//  constHeader.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef constHeader_h
#define constHeader_h

//屏幕 宽 高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

//屏幕宽度比
#define WIDTH_SCALE [UIScreen mainScreen].bounds.size.width / 375
//屏幕高度比
#define HEIGHT_SCALE [UIScreen mainScreen].bounds.size.height / 667

//RGBA Color
#define krgb(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SizeScale (kScreenW != 414 ? 1 : 1.2)
#define kFont(value) [UIFont systemFontOfSize:value * SizeScale]

/********* 去掉Cell分割线的左边距   *************/
#define kRemoveLeftSeparator(cell) \
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero;\
cell.preservesSuperviewLayoutMargins = NO;\

#define weak(T) __weak typeOf(T) weakT = T


#define userDefault [NSUserDefaults standardUserDefaults]


typedef NS_ENUM(NSUInteger, NIMMyNotiType) {
    NIMMyNotiTypeConnectMic,// 联麦
    NIMMyNotiTypeDisconnect,// 断开
};

typedef NS_ENUM(NSUInteger, weddingType) {
    weddingType_zhong,
    weddingType_xi,
    weddingType_none,
};




#endif /* constHeader_h */
