//
//  AppDelegate.m
//  DemoGather
//
//  Created by deepbaytech on 2019/11/22.
//  Copyright © 2019 SLQ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
