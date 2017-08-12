//
//  MainTabBarController.m
//
//  Created by qiang11.wei on 16/4/22.
//

#import "MainTabBarController.h"
#import "UITabBarController+QFExtension.h"
#import "firstViewController.h"
#import "secondViewController.h"
#import "thirdViewController.h"
#import "forthViewController.h"
#import "fifthViewController.h"

/** 颜色判断 */
#define UIColorRGBA(_r, _g, _b, _a) [UIColor colorWithRed:_r/255.f green:_g/255.f blue:_b/255.f alpha:_a]

#define UIColorRGB(_r, _g, _b) UIColorRGBA(_r, _g, _b, 1)

@interface MainTabBarController()
@property (nonatomic,strong) UIImageView *bgimg;
@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setController];
    
    self.bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -8, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    [self.bgimg setImage:[UIImage imageNamed:@"tabbar_bg"]];
    [self.bgimg setContentMode:UIViewContentModeCenter];
    [self.tabBar insertSubview:self.bgimg atIndex:0];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    //设置TintColor
    
    [self.tabBar setSelectionIndicatorImage:[self createImageWithColor:[UIColor clearColor]]];
    
    UITabBar.appearance.tintColor = [UIColor orangeColor];
}

- (void)setController {
    
    
    /** 首页 */
    firstViewController *index = [[firstViewController alloc] init];
    
    [self addViewController:index title:@"首页" image:@"home-2" selectedImage:@"home-1"];
    
    /** 赚吧 */
    secondViewController *profit = [[secondViewController alloc] init];
    
    [self addViewController:profit title:@"赚吧" image:@"zhuanba-2" selectedImage:@"zhuanba-1"];
    
    thirdViewController *mid = [[thirdViewController alloc] init];
    [self addViewController:mid title:@"" image:@"btn_card" selectedImage:@"btn_card@2x"];
    
    /** 商城 */
    forthViewController *shop = [[forthViewController alloc] init];
    [self addViewController:shop title:@"商城" image:@"mall-2" selectedImage:@"mall-1"];
    
    /** 个人中心 */
    fifthViewController *me = [[fifthViewController alloc] init];
    [self addViewController:me title:@"个人中心" image:@"Personal-Center-2" selectedImage:@"Personal-Center-1"];
    
    /** 设置背景 */
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackground"]];
    
    /** 设置镂空颜色 */
    [self.tabBar setTintColor:UIColorRGB(51, 132, 245)];
    
    
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//设置中间按钮不受TintColor影响
- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *items =  self.tabBar.items;
    UITabBarItem *btnAdd = items[2];
    btnAdd.image = [btnAdd.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btnAdd.selectedImage = [btnAdd.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
