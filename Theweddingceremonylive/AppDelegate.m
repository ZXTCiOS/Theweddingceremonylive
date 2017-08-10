//
//  AppDelegate.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"
#import "LoginVC.h"
#import "MainVC.h"
#import "LiveVC.h"
#import "MiddleVC.h"
#import "BBSVC.h"
#import "MineVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self confitroot];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)confitroot
{
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    UINavigationController *navcon = [[UINavigationController alloc] init];
//    LoginVC *vc = [[LoginVC alloc] init];
//    vc.title = @"首页-登录";
//    navcon.viewControllers = @[vc];
//    self.window.rootViewController = navcon;
//    [self.window makeKeyAndVisible];
    
    
        MainVC * VC0 = [[MainVC alloc] init];
        VC0.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
        UINavigationController * nav0 = [[UINavigationController alloc] initWithRootViewController:VC0];
        VC0.title = @"main";
    
        LiveVC * VC1 = [[LiveVC alloc] init];
        VC1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
        UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
        VC1.title = @"menu";
    
        MiddleVC *VC2 = [[MiddleVC alloc] init];
        UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
        VC2.title = @"vc2";
    
        BBSVC *VC3 = [[BBSVC alloc] init];
        UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
        VC3.title = @"vc3";
    
        MineVC *VC4 = [[MineVC alloc] init];
        UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:VC4];
        VC4.title = @"vc4";
        LCTabBarController * main = [[LCTabBarController alloc] init];
        main.viewControllers = @[nav0,nav1,nav2,nav3,nav4];
        self.window.rootViewController = main;
    
}

@end
