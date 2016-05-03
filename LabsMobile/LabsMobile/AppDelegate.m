//
//  AppDelegate.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Fill in your account information
    self.labsMobileClient = [[LMOClient alloc] initWithUsername:@"__YOUR_USERNAME__" // required
                                                       password:@"__YOUR_PASSWORD__" // required
                                                    environment:@"__YOUR_ENVIRONMENT__"]; // optional, can be nil
    return YES;
}

@end
