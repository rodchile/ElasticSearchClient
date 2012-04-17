//
//  AppDelegate.m
//  Example
//
//  Created by Pulkit Singhal on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <RestKit/RestKit.h>

#import "ESRequest.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

#pragma mark - Global Instance methods
- (void) setupESClient
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"config.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];

    // Initialize RestKit
    RKObjectManager *manager =
    [RKObjectManager objectManagerWithBaseURL:
     [
      NSURL URLWithString:[NSString stringWithFormat:@"%@://%@:%@/%@",
                           [plistData objectForKey:@"protocol"],
                           [plistData objectForKey:@"address"],
                           [plistData objectForKey:@"port"],
                           [plistData objectForKey:@"index"]]
     ]
    ];

    // Enable automatic network activity indicator management
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;

    // Serialize to JSON on the wire
    manager.serializationMIMEType = RKMIMETypeJSON;

    // Set the shared manager
    [RKObjectManager setSharedManager:manager];

    // Query should always hit the /_search url
    RKObjectRouter *router = [RKObjectManager sharedManager].router;
    [router routeClass:[ESRequest class] toResourcePath:@"/_search"];
}

#pragma mark - Application Lifecycle Methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupESClient];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
