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
    
    // create a new passcode
    GCPasscodeViewControllerModeCreate = 0,
    
    // used to login given that the provided passcode is correct
    GCPasscodeViewControllerModeVerify
    
} GCPasscodeViewControllerMode;

// Block called when a passcode has been created.
typedef void (^GCPasscodeCreateBlock) (NSString *code);

// Block called when a passcode should be verified.
typedef BOOL (^GCPasscodeVerifyBlock) (NSString *code);

// Abstract view controller class for entering passcodes.
@interface GCPasscodeViewController : UIViewController

// Functional properties.
@property (nonatomic, readonly, assign) GCPasscodeViewControllerMode mode;
@property (nonatomic, copy) GCPasscodeCreateBlock createBlock;
@property (nonatomic, copy) GCPasscodeVerifyBlock verifyBlock;

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
//@property (nonatomic, retain) IBOutlet UITextField *textField;

// executed every time the view is loaded
//@property (nonatomic, copy) GCPINViewControllerViewDidLoadBlock viewDidLoadBlock;

@end
