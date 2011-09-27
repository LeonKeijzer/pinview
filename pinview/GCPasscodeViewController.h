//
//  GCPINViewController.h
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright 2010 GUI Cocoa, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

// Define the availble modes for the controller to use.
typedef enum {
    
    // Create a new passcode
    GCPasscodeViewControllerModeCreate = 0,
    
    // Standard login controller
    GCPasscodeViewControllerModeVerify
    
} GCPasscodeViewControllerMode;

/*
 Block called when a passcode event occurs.
 
 If the controller is in `create` mode the code being passed in is what the user
 would like to save. Returning `NO` will force the user to provide another
 passcode. You can do input validation here and present alerts if necessary.
 
 If the controller is in `verify` mode the code passed in is what the user is
 attempting to authenticate with. You can perform custom logic here, like a
 "number of attempts" counter.
 */
typedef BOOL (^GCPasscodeBlock) (NSString *code);

// Abstract view controller class for entering passcodes.
@interface GCPasscodeViewController : UIViewController

// properties
@property (nonatomic, readonly, assign) GCPasscodeViewControllerMode mode;
@property (nonatomic, copy) GCPasscodeBlock passcodeBlock;

// Create a passcode view controller with the given mode.
- (id)initWithMode:(GCPasscodeViewControllerMode)mode;

// Present a passcode view controller wrapped in a navigation controller.
- (void)presentFromViewController:(UIViewController *)controller animated:(BOOL)animated;

// Dismiss a passcode view after the given delay (in seconds)
- (void)dismissAfterDelay:(double)delay;

//// used in both text and pattern modes
//@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
//@property (nonatomic, retain) IBOutlet UILabel *errorLabel;
//@property (nonatomic, retain) IBOutlet UIView *backgroundView;
//
//// used in text mode
//

// executed every time the view is loaded
//@property (nonatomic, copy) GCPINViewControllerViewDidLoadBlock viewDidLoadBlock;

@end
