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
//  UIDatePicker:frame = (0 64; 375 216);
//  默认显示的是 yyyy-MM-dd

#import "YUDatePicker.h"

#define kYUDatePickerScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kYUDatePickerScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kColorDatePickerTheme   ([UIColor colorWithRed:(18)/255.0f green:(175)/255.0f blue:(114)/255.0f alpha:1.0f])

#define kTitleNormalColor  [UIColor colorWithRed:22/255.f green:126/255.f blue:251/255.f alpha:1.f]
#define kTitleHighlightedColor    [UIColor grayColor]

static const CGFloat kDateControlFont = 18.f;
static const CGFloat kAnimationTime = 0.2f;

@interface YUDatePicker ()

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UIDatePicker *datePicker;

/** 被选中的日期 */
@property (nonatomic, copy) NSString *currentDateStr;

/** 日期格式 */
@property (nonatomic, copy) NSString *kDateFormat;

@property (nonatomic, copy) HandleYUDatePicker clickBlock;
@end

@implementation YUDatePicker

+ (void)showAndHandleResult:(HandleYUDatePicker)clickBlock {
    YUDatePicker *datePicker = [[self alloc] initWithFrame:CGRectMake(0, 0, kYUDatePickerScreenWidth, kYUDatePickerScreenHeight)];
    [datePicker show];
    datePicker.clickBlock = clickBlock;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.kDateFormat = @"yyyy-MM-dd";
        self.frame = CGRectMake(0, 0, kYUDatePickerScreenWidth, kYUDatePickerScreenHeight);
        // 1.设置默认状态
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        // 2.添加控件
        [self setupControls];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapYUDatePicker)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)tapYUDatePicker {
    [self removeFromSuperview];
}
// 2.添加控件
- (void)setupControls {
    // 1.容器
    UIView *dateContainer = [[UIView alloc] init];
    dateContainer.backgroundColor = [UIColor whiteColor];
    CGFloat dateContainerW = kYUDatePickerScreenWidth;
    if (kYUDatePickerScreenWidth > 414 && kYUDatePickerScreenHeight >736) {
        dateContainerW = 500.f;
    }
    [self addSubview:dateContainer];

    
    CGFloat dateBtnW = 80.f;
    CGFloat dateBtnH = 50.f;
    // 2.取消按钮
    UIButton *leftBtn = [[UIButton alloc] init];
    self.leftBtn = leftBtn;
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitle:@"取消" forState:UIControlStateHighlighted];
    [leftBtn setTitleColor:kTitleNormalColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:kTitleHighlightedColor forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:kDateControlFont];
    [leftBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    leftBtn.frame = CGRectMake(0, 0, dateBtnW, dateBtnH);
    [dateContainer addSubview:leftBtn];
    
    // 3.确定按钮
    UIButton *rightBtn = [[UIButton alloc] init];
    self.rightBtn = rightBtn;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:kTitleNormalColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:kTitleHighlightedColor forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:kDateControlFont];
    [rightBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 2;
    CGFloat dateSureBtnX = dateContainerW-dateBtnW;
    rightBtn.frame = CGRectMake(dateSureBtnX, 0, dateBtnW, dateBtnH);
    [dateContainer addSubview:rightBtn];
    
    // 4.显示选中日期的 Label
    UILabel *dateLab = [[UILabel alloc] init];
    self.dateLab = dateLab;
    dateLab.textColor = [UIColor blackColor];
    dateLab.font = [UIFont systemFontOfSize:kDateControlFont];
    dateLab.textAlignment = NSTextAlignmentCenter;
    
    NSString *formattedDateString = [self yu_dateWith:[NSDate date] dateFormat:self.kDateFormat];
    dateLab.text = formattedDateString;
    self.currentDateStr = formattedDateString;
    CGFloat dateLabX = dateBtnW;
    CGFloat dateLabW = dateContainerW-2*dateBtnW;
    dateLab.frame = CGRectMake(dateLabX, 0, dateLabW, dateBtnH);
    [dateContainer addSubview:dateLab];
    
    // 5.添加 datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    datePicker.backgroundColor = [UIColor whiteColor];
    // 设置时区
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [datePicker setTimeZone:zone];
    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setCalendar:[NSCalendar currentCalendar]];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(dateChanged:)forControlEvents:UIControlEventValueChanged];
    CGFloat datePickerY = CGRectGetMaxY(leftBtn.frame);
    CGFloat datePickerW = dateContainerW;
    CGFloat datePickerH = 216.f;
    datePicker.frame = CGRectMake(0, datePickerY, datePickerW, datePickerH);
    [dateContainer addSubview:datePicker];
    
    CGFloat dateContainerH = CGRectGetMaxY(datePicker.frame);
    CGFloat dateContainerX = (kYUDatePickerScreenWidth-dateContainerW)/2;
    CGFloat dateContainerY = kYUDatePickerScreenHeight - dateContainerH;
    if (kYUDatePickerScreenWidth > 414 && kYUDatePickerScreenHeight > 736) {
        dateContainerY = (kYUDatePickerScreenHeight-dateContainerH)/2;
    }
    dateContainer.frame = CGRectMake(dateContainerX, dateContainerY, dateContainerW, dateContainerH);
    
    [self addAnimationIn:dateContainer];
}

- (void)addAnimationIn:(UIView *)view {
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = kAnimationTime;
    //先慢后快
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:@"animation"];
}

/** DatePicker日期滑动 */
- (void)dateChanged:(UIDatePicker *)picker
{
    NSDate *date = picker.date;
    NSString *formattedDateString = [self yu_dateWith:date dateFormat:self.kDateFormat];
    
    self.dateLab.text = formattedDateString;
    
    self.currentDateStr = formattedDateString;
}

- (void)yu_datePickerHandleClick:(nullable HandleYUDatePicker)clickBlock {
    self.clickBlock = clickBlock;
}

- (void)dateBtnClick:(UIButton *)btn {
    self.clickBlock(self.currentDateStr,btn.tag);
    [self removeFromSuperview];
}

#pragma mark - Set
- (void)setDatePickerModel:(YUDatePickerMode)datePickerModel {
    if (datePickerModel == YUDatePickerModeTime) {
        [self.datePicker setDatePickerMode:UIDatePickerModeTime];
        [self changeDatePickerModelWithFormat:@"HH:mm"];
    } else if (datePickerModel == YUDatePickerModeDate) {
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        [self changeDatePickerModelWithFormat:@"yyyy-MM-dd"];
    } else if (datePickerModel == YUDatePickerModeDateAndTime) {
        [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [self changeDatePickerModelWithFormat:@"yyyy-MM-dd HH:mm"];
    } else if (datePickerModel == YUDatePickerModeCountDownTimer) {
        [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        [self changeDatePickerModelWithFormat:@"HH:mm"];
    }
}
- (void)changeDatePickerModelWithFormat:(NSString *)format {
    self.kDateFormat = format;
    NSString *formattedDateString = [self yu_dateWith:[NSDate date] dateFormat:format];
    self.dateLab.text = formattedDateString;
}
- (void)setDateFormatStr:(NSString *)dateFormatStr {
    _dateFormatStr = dateFormatStr;
    [self changeDatePickerModelWithFormat:dateFormatStr];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    [self.datePicker setMinimumDate:minimumDate];
}
- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    [self.datePicker setMaximumDate:maximumDate];
}

- (NSString *)yu_dateWith:(NSDate *)date dateFormat:(NSString *)dateFormat {
    // 1.设定日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    // 2.日期转为字符串
    // localDateStr的值是北京时间
    NSString *localDateStr = [dateFormatter stringFromDate:date];
    
    return localDateStr;
}

@end
