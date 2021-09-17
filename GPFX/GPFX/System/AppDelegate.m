//
//  AppDelegate.m
//  GPFX
//
//  Created by apple on 2021/1/18.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "AppDelegate.h"
#import "GPMainViewController.h"
#import "GPAllViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GPMainViewController *main = [[GPMainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    
    GPAllViewController *all = [[GPAllViewController alloc] init];
    UINavigationController *allNav = [[UINavigationController alloc] initWithRootViewController:all];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[allNav, mainNav];
    
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
