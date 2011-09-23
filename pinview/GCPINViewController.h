//
//  GCPINViewController.h
//  PINCode
//
//  Created by Caleb Davenport on 8/28/10.
//  Copyright 2010 GUI Cocoa, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GCPINViewControllerViewDidLoadBlock) ();

@interface GCPINViewController : UIViewController <UITextFieldDelegate> {
@private
    UITextField     *__textField;
    UILabel         *__messageLabel;
	UILabel         *__errorLabel;
}

/*
 User interface properties.
 */
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *errorLabel;
@property (nonatomic, copy) GCPINViewControllerViewDidLoadBlock viewDidLoadBlock;

/*
 Present a PIN code view controller wrapped in a navigation controller.
 */
- (void)presentViewFromViewController:(UIViewController *)controller animated:(BOOL)animated;

@end
