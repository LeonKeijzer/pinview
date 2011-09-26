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

#pragma mark - actions
- (IBAction)setPasscode {
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"Cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Pattern", @"Text", nil];
    [sheet showInView:self.view];
    [sheet release];
}

#pragma mark - action sheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    if (buttonIndex >= actionSheet.numberOfButtons) {
        return;
    }
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Pattern"]) {
        
        GCPatternPasscodeViewController *controller = [[GCPatternPasscodeViewController alloc]
                                                       initWithNibName:nil
                                                       bundle:nil];
        [controller setCreateBlock:^(NSString *string) {
            NSLog(@"set passcode: %@", string);
        }];
        [controller presentFromViewController:self animated:YES];
        [controller release];
        
    }
    else if ([title isEqualToString:@"Text"]) {
        
    }
}

@end
