//
//  TMAppDelegate.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMAppDelegate.h"
#import "TMViewController.h"
#import "BlockAlertView.h"

#import "Appirater.h"
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
    
    
    [Appirater setAppId:@"424742506"];
    [Appirater setDaysUntilPrompt:3];
    [Appirater setUsesUntilPrompt:3];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:3];
    [Appirater setUsesAnimation:YES];
    
#if !APPSTORE
    [Appirater setDebug:YES];
#else
    [Appirater setDebug:NO];
#endif
    

    BlockAlertView *alert = [BlockAlertView alertWithTitle:NSLocalizedString(@"app_welcome_title", @"")
                                                   message:NSLocalizedString(@"app_welcome_subtitle", @"")];
    
    [alert setCancelButtonWithTitle:NSLocalizedString(@"app_enjoy", @"")
                              block:^{
                                  
                                  double delayInSeconds = 1.0;
                                  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,
                                                                          (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                  
                                  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                      
                                      [Appirater appLaunched:YES];
                                      
                                  });
                              }];
    
    [alert show];

    return YES;
}


@end
