//
//  MainTabBarController.m
//
//  Created by qiang11.wei on 16/4/22.
//

#import "MainTabBarController.h"
#import "UITabBarController+QFExtension.h"
#import "LiveVC.h"
#import "MainVC.h"
#import "MiddleVC.h"
#import "BBSVC.h"
#import "MineTVC.h"

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
    
    
    /** 视频 */
    LiveVC *index = [[LiveVC alloc] init];
    
    [self addViewController:index title:@"" image:@"TabBar1" selectedImage:@"TabBar1Sel"];
    
    /** 首页 */
    MainVC *profit = [[MainVC alloc] init];
    
    [self addViewController:profit title:@"" image:@"TabBar2" selectedImage:@"TabBar2Sel"];
    
    MiddleVC *mid = [[MiddleVC alloc] init];
    [self addViewController:mid title:@"" image:@"摄影机图标_点击前" selectedImage:@"摄影机图标_点击后"];
    
    /** bbs */
    BBSVC *shop = [[BBSVC alloc] init];
    [self addViewController:shop title:@"" image:@"TabBar4" selectedImage:@"TabBar4Sel"];
    
    /** 个人中心 */
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MineTVC *me = [sb instantiateInitialViewController];
    [self addViewController:me title:@"个人中心" image:@"TabBar5" selectedImage:@"TabBar5Sel"];
    
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
