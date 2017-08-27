//
//  关注微博：裕之都
//  微博地址：http://weibo.com/gou9527
//
//  Github：https://github.com/yuzhidu
//  Copyright © 裕之都. All rights reserved.
//  使用环境:ARC
//  Version:1.1
//  适用：iPhone & iPad
//
//  默认显示的是 yyyy-MM-dd
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YUDatePickerMode) {
    // 上午/下午 xx xx  例如:上午 6 35
    YUDatePickerModeTime,
    
    //  xxxx年 xx月 xx日  例如:2015年 12月 21日
    YUDatePickerModeDate,
    
    // xx月xx日  周x 下午 xx xx  例如:12月30日 周二 下午 5 55 (注意:只显示本年,不能选择其它年份)
    YUDatePickerModeDateAndTime,
    
    // xx小时 xx分钟  例如:20小时 50分钟
    YUDatePickerModeCountDownTimer,
};

typedef void(^HandleYUDatePicker)(NSString * __nullable dateStr,NSInteger buttonIndex);

@interface YUDatePicker : UIView

/** 时间格式 模式默认是 YUDatePickerModeDate，如果修改模式，必定要修改时间显示格式 */
@property (nonatomic, assign) YUDatePickerMode datePickerModel;

/** 默认显示的是 yyyy/MM/dd, 修改时间显示格式, 在此修改，注意日期格式要对应日期模式 */
@property (nonatomic, copy, nonnull) NSString *dateFormatStr;

@property (nullable, nonatomic, strong) NSDate *minimumDate;
@property (nullable, nonatomic, strong) NSDate *maximumDate;

/** 左侧按钮 */
@property (nonatomic, weak, nullable) UIButton *leftBtn;
/** 右侧按钮 */
@property (nonatomic, weak, nullable) UIButton *rightBtn;

- (void)yu_datePickerHandleClick:(nullable HandleYUDatePicker)clickBlock;

/**
 *  显示DatePicker
 */
- (void)show;

+ (void)showAndHandleResult:(__nullable HandleYUDatePicker)clickBlock;

@end
