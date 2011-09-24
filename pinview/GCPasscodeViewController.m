//
//  GCPINViewController.m
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright 2010 GUI Cocoa, LLC. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "GCPasscodeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface GCPasscodeViewController (private)
- (void)setErrorLabelHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)updatePINDisplay;
@end

@implementation GCPasscodeViewController (private)
- (void)setErrorLabelHidden:(BOOL)hidden animated:(BOOL)animated {
//	if (animated) {
//		[UIView beginAnimations:nil context:nil];
//	}
//	
//	errorLabel.alpha = (hidden) ? 0.0 : 1.0;
//	
//	if (animated) {
//		[UIView commitAnimations];
//	}
}
- (void)updatePINDisplay {
//	for (NSInteger i = 0; i < [PINText length]; i++) {
//	  UILabel *label = [pinFields objectAtIndex:i];
//		if (self.secureTextEntry) {
//			[label setText:@"●"];
//		}
//		else {
//			NSRange subrange = NSMakeRange(i, 1);
//			NSString *substring = [PINText substringWithRange:subrange];
//			[label setText:substring];
//		}
//	}
//	for (NSInteger i = [PINText length]; i < 4; i++) {
//		UILabel *label = [pinFields objectAtIndex:i];
//		[label setText:@""];
//	}
}
@end

@interface GCPasscodeViewController ()
@property (nonatomic, assign) GCPasscodeViewControllerType type;
@property (nonatomic, assign) GCPasscodeViewControllerMode mode;
@end

@implementation GCPasscodeViewController

@synthesize type = __type;
@synthesize mode = __mode;

@synthesize textField = __textField;
@synthesize messageLabel = __messageLabel;
@synthesize errorLabel = __errorLabel;
@synthesize viewDidLoadBlock = __viewDidLoad;

#pragma mark - object methods
- (id)initWithNibName:(NSString *)nib
               bundle:(NSBundle *)bundle
                 type:(GCPasscodeViewControllerType)type
                 mode:(GCPasscodeViewControllerMode)mode {
    self = [super initWithNibName:nib bundle:bundle];
    if (self) {
        self.type = type;
        self.mode = mode;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(textFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:nil];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UITextFieldTextDidChangeNotification
     object:nil];
    self.textField = nil;
    self.errorLabel = nil;
    self.messageLabel = nil;
    self.viewDidLoadBlock = nil;
    [super dealloc];
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // text mode
    if (self.mode == GCPasscodeViewControllerTypeText) {
        UIImage *image = [UIImage imageNamed:@"PINBox"];
        image = [image stretchableImageWithLeftCapWidth:25 topCapHeight:0];
        self.textField.background = image;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.secureTextEntry = YES;
    }
    
    // pattern mode
    else {
        
    }
    
    // default view state
    
    self.errorLabel.hidden = YES;
    
    // perform user actions
//    if (self.viewDidLoadBlock) {
//        self.viewDidLoadBlock();
//    }
	
    // configure text field
    self.textField.delegate = self;
    [self.textField becomeFirstResponder];
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
    self.textField = nil;
    self.errorLabel = nil;
    self.messageLabel = nil;
}

#pragma mark -
#pragma mark show view controller
- (void)presentViewFromViewController:(UIViewController *)controller animated:(BOOL)animated {
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self];
	[controller presentModalViewController:navController animated:animated];
	[navController release];
}

#pragma mark - text field methods
- (void)textFieldTextDidChange:(NSNotification *)notif {
    if (self.textField && self.textField == [notif object]) {
        
    }
    
    
//	UITextField *field = [notif object];
//	if (field == inputField) {
//		NSString *newText = field.text;
//		
//		if ([newText length] == 4) {
//			NSString *toValidate = [field.text copy];
//			BOOL valid = [delegate pinView:self validateCode:toValidate];
//			[toValidate release];
//			if (!valid) {
//				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//				[self setErrorLabelHidden:NO animated:YES];
//				inputField.text = @"";
//			}
//		}
//		else {
//			[PINText release];
//			PINText = [newText copy];
//		}
//		
//		[self updatePINDisplay];
//	}
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//	if ([PINText length] == 4 && [string length] > 0) {
//		return NO;
//	}
//	else {
//		[self setErrorLabelHidden:YES animated:YES];
//		return YES;
//	}
    return YES;
}

@end
