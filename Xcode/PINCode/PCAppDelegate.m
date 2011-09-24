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

#pragma mark -
#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 

    // root view controller
    UIViewController *controller = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = controller;
    [controller release];
    
    // show window
    [self.window makeKeyAndVisible];
    
    // show pin screen
    GCPasscodeViewController *PINController = [[GCPasscodeViewController alloc] initWithNibName:@"PINViewDefault" bundle:nil];
    PINController.viewDidLoadBlock = ^{
        PINController.messageLabel.text = @"Message";
        PINController.errorLabel.text = @"Error";
    };
    [PINController presentViewFromViewController:self.window.rootViewController animated:YES];
    [PINController release];
    
    // return
    return YES;
    
}

#pragma mark -
#pragma mark GCPINViewControllerDelegate
- (BOOL)pinView:(GCPasscodeViewController *)pinView validateCode:(NSString *)code {
	BOOL correct = [code isEqualToString:@"1234"];
	if (correct) {
		[pinView dismissModalViewControllerAnimated:YES];
	}
	return correct;
}

#pragma mark - memory management
- (void)dealloc {
    self.window = nil;
    [super dealloc];
}

@end
