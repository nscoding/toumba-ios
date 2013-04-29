//
//  TMAppDelegate.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMAppDelegate.h"
#import "TMViewController.h"

#import "TestFlight.h"


// ------------------------------------------------------------------------------------------


@implementation TMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#if !APPSTORE
    [TestFlight takeOff:@"83c7de9f-c594-43e5-b2cb-12c2fa57da1e"];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[TMViewController alloc] initWithNibName:@"TMViewController" bundle:nil];

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
