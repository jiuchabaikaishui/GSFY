//
//  AppDelegate.m
//  GPFX
//
//  Created by apple on 2021/1/18.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "AppDelegate.h"
#import "GPMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GPMainViewController *main = [[GPMainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
