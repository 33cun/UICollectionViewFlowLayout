//
//  AppDelegate.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    window.rootViewController = nav;
    
    self.window = window;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
