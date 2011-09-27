//
//  GCTextPasscodeViewController.m
//  PINCode
//
//  Created by Caleb Davenport on 9/26/11.
//  Copyright 2011 GUI Cocoa, LLC. All rights reserved.
//

#import "GCTextPasscodeViewController.h"

@implementation GCTextPasscodeViewController

@synthesize textField = __textField;

- (id)initWithMode:(GCPasscodeViewControllerMode)mode {
    self = [super initWithMode:mode];
    if (self) {
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
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImage *image = [UIImage imageNamed:@"PINBox"];
    image = [image stretchableImageWithLeftCapWidth:25 topCapHeight:0];
    self.textField.background = image;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.secureTextEntry = YES;
    [self.textField becomeFirstResponder];
}
- (void)textFieldTextDidChange:(NSNotification *)notif {
    
}

@end
