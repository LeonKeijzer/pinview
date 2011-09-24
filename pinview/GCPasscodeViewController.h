//
//  GCPINViewController.h
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright 2010 GUI Cocoa, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCPasscodePatternControl;

// Block called on `viewDidLoad`.
typedef void (^GCPINViewControllerViewDidLoadBlock) ();

// Define the type of passcode controller to use.
typedef enum {
    
    // text passcode, either as a PIN or full text passcode
    GCPasscodeViewControllerTypeText = 0,
    
    // pattern passcode
    GCPasscodeViewControllerTypePattern
    
} GCPasscodeViewControllerType;

// Define the mode for the controller to use.
typedef enum {
    
    // create a new passcode
    GCPasscodeViewControllerModeCreate = 0,
    
    // used to login given that the provided passcode is correct
    GCPasscodeViewControllerModeVerify
    
} GCPasscodeViewControllerMode;

/*
 
 */
@interface GCPasscodeViewController : UIViewController <UITextFieldDelegate>

// used in both text and pattern modes
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *errorLabel;

// used in text mode
@property (nonatomic, retain) IBOutlet UITextField *textField;

// used in pattern mode
@property (nonatomic, retain) IBOutlet GCPasscodePatternControl *patternControl;

// executed every time the view is loaded
@property (nonatomic, copy) GCPINViewControllerViewDidLoadBlock viewDidLoadBlock;

// Create a passcode view controller given the nib, type, and mode information.
- (id)initWithNibName:(NSString *)nib
               bundle:(NSBundle *)bundle
                 type:(GCPasscodeViewControllerType)type
                 mode:(GCPasscodeViewControllerMode)mode;

// Present a PIN code view controller wrapped in a navigation controller.
- (void)presentFromViewController:(UIViewController *)controller
                         animated:(BOOL)animated;

@end
