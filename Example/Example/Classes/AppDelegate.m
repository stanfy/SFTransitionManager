//
//  AppDelegate.m
//  Example
//
//  Created by Vitalii Bogdan on 5/25/15.
//  Copyright (c) 2015 Stanfy. All rights reserved.
//


#import "AppDelegate.h"
#import "SFMainViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[SFMainViewController new]];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end