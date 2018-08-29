//
//  YFBAppDelegate.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "YFBAppDelegate.h"
#import "YFBApplication.h"
#import "YFBNavigationController.h"
#import "Constants.h"
#import "ColorConstans.h"
#import "ColorToImage.h"
#import "YFBRoute.h"
#import "YFBRouter.h"

@interface YFBAppDelegate ()

@end

@implementation YFBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UNUserNotificationCenter.currentNotificationCenter removeAllPendingNotificationRequests];
    [application setApplicationIconBadgeNumber:0];
    application.statusBarStyle  = UIStatusBarStyleLightContent;
    application.statusBarHidden = NO;

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.backgroundColor = HexRGB(colorB8);
    self.window.autoresizesSubviews = YES;
    [self.window makeKeyAndVisible];
    
    self.navController=[[YFBNavigationController alloc] init];
    [self.navController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navController;
    
    [self initMainViewWithParams:nil];
    [self configNavigationBarForIPhone];
    
    YFBApplication *yfbApplication = SharedApplication;
    
    [yfbApplication application:self didFinishLaunchingWithOptions:launchOptions];
    
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

- (void)initMainViewWithParams:(NSDictionary *)params {
    
    UIViewController *rootController = [self startMainViewControllerWithParams:params];
    NSParameterAssert([rootController isKindOfClass:UINavigationController.class]);
    [SharedApplication pushNavigationController:(UINavigationController *)rootController];
    
    self.window.rootViewController = rootController;
}
                                        
- (UIViewController *)startMainViewControllerWithParams:(NSDictionary *)dict {
    YFBRoute *route = [YFBRoute routeFromString:@"YFBMainViewModel"];
    UIViewController *viewController = [[YFBRouter sharedRouter] viewControllerWithRoute:route params:dict callback:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}


// 设置navigationBar
- (void)configNavigationBarForIPhone {
    [UINavigationBar.appearance setBackgroundImage:[ColorToImage createImageWithColor:HexRGB(0x1A91EB)] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar.appearance.tintColor = [UIColor whiteColor];
    UINavigationBar.appearance.shadowImage = [UIImage new];
    [UINavigationBar.appearance setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    
    UINavigationBar.appearance.backIndicatorImage = [UIImage imageNamed:@"back_w"];
    UINavigationBar.appearance.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_w"];
    UINavigationBar.appearance.barStyle = UIBarStyleDefault;
    
    UISwitch.appearance.onTintColor = HexRGB(colorA17);
    
    UISearchBar.appearance.tintColor    = HexRGB(colorA17);
    UISearchBar.appearance.barTintColor = HexRGB(colorB8);
    UISearchBar.appearance.backgroundColor = [UIColor clearColor];
    UISearchBar.appearance.backgroundImage = [ColorToImage createImageWithColor:HexRGB(0xE0E0E0)];
    
    UITableView.appearance.backgroundColor = HexRGB(colorB11);
    UITableView.appearance.separatorColor  = HexRGB(colorB2);
    [UITableView appearance].tintColor = HexRGB(colorA17);
    
    UITableViewHeaderFooterView.appearance.tintColor = HexRGB(colorB8);
    
    [UISegmentedControl appearance].tintColor = HexRGB(colorA17);
    UISlider.appearance.tintColor    = HexRGB(colorA17);
}


@end
