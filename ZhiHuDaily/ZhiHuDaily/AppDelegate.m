//
//  AppDelegate.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MineViewController.h"
#import <ECSlidingViewController.h>

@interface AppDelegate ()
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    HomePageViewController *homePageVC = [[HomePageViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *homePageNavigation = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    MineViewController *leftViewController = [[MineViewController alloc] init];
//     UINavigationController *leftNavigation = [[UINavigationController alloc] initWithRootViewController:leftViewController];
//    leftViewController.navigationController.navigationBarHidden = YES;
    
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:homePageNavigation];
//    self.slidingViewController.underLeftViewController  = leftNavigation;
    self.slidingViewController.underLeftViewController = leftViewController;
    
    // enable swiping on the top view
    [homePageNavigation.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = 100.0;
    
    self.window.rootViewController = self.slidingViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
