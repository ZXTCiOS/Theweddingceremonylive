//
//  AppDelegate.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginVC.h"
#import "ZTVendorManager.h"
// 网易云信 SDK
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate ()<NIMLoginManagerDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ZTVendorManager registerVendorSDK];
    [self confitroot];
    [self configNimSDK];
    [self autoLogin];
    
    [self configJPushoptions:launchOptions];

    return YES;
}

#pragma mark 极光推送

- (void)configJPushoptions:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"48a4889e047c006938c2b298"
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
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


- (void)configNimSDK{
    NSString *appKey        = @"55c573ae6c0fb6d673a401954b3d5c5b";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    //TODO: 添加 apns
    option.apnsCername      = @"your APNs cer name";
    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
}

- (void)autoLogin{
    
    NIMAutoLoginData *data = [[NIMAutoLoginData alloc] init];
    data.account = [userDefault objectForKey:user_phone];
    data.token = [userDefault objectForKey:user_imtoken];
    data.forcedMode = NO;
    [[NIMSDK sharedSDK].loginManager autoLogin:data];
}

#pragma mark - 自动登录回调

- (void)onLogin:(NIMLoginStep)step{
    NSLog(@"自动登录   %ld", step);
}

- (void)onAutoLoginFailed:(NSError *)error{
    NSLog(@"---------------自动登录失败----------%@", error);
}



-(void)confitroot
{
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *token = [defat objectForKey:user_token];
    
    if ([strisNull isNullToString:token]) {
        UINavigationController *navcon = [[UINavigationController alloc] init];
        LoginVC *vc = [[LoginVC alloc] init];
        navcon.viewControllers = @[vc];
        self.window.rootViewController = navcon;
        [self.window makeKeyAndVisible];
    }
    else
    {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = [[MainTabBarController alloc] init];
        [self.window makeKeyAndVisible];

    }
    

    
}





@end
