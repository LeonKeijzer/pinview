//
//  RootViewController.m
//  PINCode
//
//  Created by Caleb Davenport on 9/24/11.
//  Copyright 2011 GUI Cocoa, LLC. All rights reserved.
//

#import "RootViewController.h"

#import "GCPatternPasscodeViewController.h"

@implementation RootViewController

- (IBAction)setPatternPasscode {
    GCPatternPasscodeViewController *controller = [[GCPatternPasscodeViewController alloc]
                                                   initWithMode:GCPasscodeViewControllerModeCreate];
    [controller setCreateBlock:^(NSString *string) {
        NSLog(@"set passcode: %@", string);
    }];
    [controller presentFromViewController:self animated:YES];
    [controller release];
}
- (IBAction)checkPatternPasscode {
    GCPatternPasscodeViewController *controller = [[GCPatternPasscodeViewController alloc]
                                                   initWithMode:GCPasscodeViewControllerModeVerify];
    [controller setVerifyBlock:^(NSString *string) {
        return [string isEqualToString:@"0125"];
    }];
    [controller presentFromViewController:self animated:YES];
    [controller release];
}

@end
