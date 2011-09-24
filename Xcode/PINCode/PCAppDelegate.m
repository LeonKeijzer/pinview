//
//  PINCodeAppDelegate.m
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright GUI Cocoa, LLC. 2010. All rights reserved.
//

#import "PCAppDelegate.h"

#import "GCPasscodeViewController.h"

@implementation PCAppDelegate

@synthesize window = __window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)dealloc {
    self.window = nil;
    [super dealloc];
}

@end
