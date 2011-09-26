//
//  GCPINViewController.m
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright 2010 GUI Cocoa, LLC. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "GCPasscodeViewController.h"

@interface GCPasscodeViewController ()
@property (nonatomic, readwrite, assign) GCPasscodeViewControllerMode mode;
@end

@implementation GCPasscodeViewController

@synthesize mode = __mode;
@synthesize createBlock = __createBlock;
@synthesize verifyBlock = __verifyBlock;

//@synthesize messageLabel = __messageLabel;
//@synthesize errorLabel = __errorLabel;
//@synthesize textField = __textField;
//@synthesize viewDidLoadBlock = __viewDidLoad;
//@synthesize backgroundView = __backgroundView;

#pragma mark - object methods
- (id)initWithMode:(GCPasscodeViewControllerMode)mode {
    NSAssert(mode == GCPasscodeViewControllerModeCreate || mode == GCPasscodeViewControllerModeVerify,
             @"Invalid passcode mode");
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.mode = mode;
    }
    return self;
}
//- (id)initWithNibName:(NSString *)nib
//               bundle:(NSBundle *)bundle
//                 mode:(GCPasscodeViewControllerMode)mode {
//    self = [super initWithNibName:nib bundle:bundle];
//    if (self) {
//        self.mode = mode;
//        if (self.mode == GCPasscodeViewControllerModeCreate) {
//            self.title = @"Create Passcode";
//        }
//        else {
//            self.title = @"Login";
//        }
//        [[NSNotificationCenter defaultCenter]
//         addObserver:self
//         selector:@selector(textFieldTextDidChange:)
//         name:UITextFieldTextDidChangeNotification
//         object:nil];
//    }
//    return self;
//}
- (void)dealloc {
    self.createBlock = nil;
    self.verifyBlock = nil;
//    [[NSNotificationCenter defaultCenter]
//     removeObserver:self
//     name:UITextFieldTextDidChangeNotification
//     object:nil];
//    self.textField = nil;
//    self.errorLabel = nil;
//    self.messageLabel = nil;
//    self.viewDidLoadBlock = nil;
    [super dealloc];
}
- (void)presentFromViewController:(UIViewController *)controller animated:(BOOL)animated {
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self];
	[controller presentModalViewController:navController animated:animated];
	[navController release];
}
- (void)dismissAfterDelay:(double)delay {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self dismissModalViewControllerAnimated:YES];
    });
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // default view state
//    UIImage *image = [UIImage imageNamed:@"PINBox"];
//    image = [image stretchableImageWithLeftCapWidth:25 topCapHeight:0];
//    self.textField.background = image;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
//    self.textField.secureTextEntry = YES;
//    self.errorLabel.hidden = YES;
//    
//    // perform user actions
//    if (self.viewDidLoadBlock) {
//        self.viewDidLoadBlock();
//    }
//    
//    [self.view addSubview:self.backgroundView];
//    [self.view sendSubviewToBack:self.backgroundView];
//	
//    // configure text field
//    self.textField.delegate = self;
//    [self.textField becomeFirstResponder];
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
//    self.textField = nil;
//    self.errorLabel = nil;
//    self.messageLabel = nil;
}


#pragma mark - text field methods
- (void)textFieldTextDidChange:(NSNotification *)notif {
//    if (self.textField && self.textField == [notif object]) {
//        
//    }
    
    
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
