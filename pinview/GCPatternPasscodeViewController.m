//
//  GCPatternPasscodeViewController.m
//  PINCode
//
//  Created by Caleb Davenport on 9/25/11.
//  Copyright 2011 GUI Cocoa, LLC. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "GCPatternPasscodeViewController.h"
#import "GCPasscodePatternControl.h"

@interface GCPatternPasscodeViewController ()
@property (nonatomic, retain) GCPasscodePatternControl *firstPattern;
@property (nonatomic, retain) GCPasscodePatternControl *secondPattern;
@property (nonatomic, copy) NSString *patternString;
+ (GCPasscodePatternControl *)patternControlWithFrame:(CGRect)frame;
@end

@implementation GCPatternPasscodeViewController

@synthesize firstPattern = __firstPattern;
@synthesize secondPattern = __secondPattern;
@synthesize patternString = __patternString;

#pragma mark - class methods
+ (GCPasscodePatternControl *)patternControlWithFrame:(CGRect)frame {
    GCPasscodePatternControl *control = [[GCPasscodePatternControl alloc] initWithFrame:frame];
    control.backgroundColor = [UIColor clearColor];
    control.opaque = YES;
    control.userInteractionEnabled = YES;
    control.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleTopMargin);
    return [control autorelease];
}

#pragma mark - object methods
- (void)dealloc {
    self.firstPattern = nil;
    self.secondPattern = nil;
    self.patternString = nil;
    [super dealloc];
}
- (void)patternControlValueChanged:(GCPasscodePatternControl *)control {
    if (self.mode == GCPasscodeViewControllerModeCreate) {
        CGRect middle = control.frame;
        CGRect right = CGRectOffset(middle, self.view.bounds.size.width, 0.0);
        CGRect left = CGRectOffset(middle, self.view.bounds.size.width * -1.0, 0.0);
        if (control == self.firstPattern) {
            self.patternString = [control patternString];
            self.secondPattern = [GCPatternPasscodeViewController patternControlWithFrame:right];
            [self.secondPattern addTarget:self action:_cmd forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:self.secondPattern];
            [UIView
             animateWithDuration:0.3
             delay:0.5
             options:0
             animations:^{
                 self.firstPattern.frame = left;
                 self.secondPattern.frame = middle;
             }
             completion:nil];
        }
        else if (control == self.secondPattern) {
            if ([self.patternString isEqualToString:[control patternString]]) {
                if (self.createBlock) { self.createBlock(self.patternString); }
                control.color = GCPasscodePatternControlColorGreen;
                [self dismissAfterDelay:0.5];
            }
            else {
                self.patternString = nil;
                [self.firstPattern clearPattern];
                control.color = GCPasscodePatternControlColorRed;
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                [UIView
                 animateWithDuration:0.3
                 delay:0.5
                 options:0
                 animations:^{
                     self.secondPattern.frame = right;
                     self.firstPattern.frame = middle;
                 }
                 completion:^(BOOL finished) {
                     [self.secondPattern removeFromSuperview];
                     self.secondPattern = nil;
                 }];
            }
        }
    }
    else {
        BOOL verified = NO;
        if (self.verifyBlock) { verified = self.verifyBlock([control patternString]); }
        if (verified) {
            control.color = GCPasscodePatternControlColorGreen;
            [self dismissAfterDelay:0.5];
        }
        else {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [control clearPattern];
            control.color = GCPasscodePatternControlColorRed;
            control.userInteractionEnabled = NO;
            double delay = 0.5;
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^(void){
                control.color = GCPasscodePatternControlColorWhite;
                control.userInteractionEnabled = YES;
            });
        }
    }
}
- (void)presentFromViewController:(UIViewController *)controller animated:(BOOL)animated {
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self];
	[controller presentModalViewController:navController animated:animated];
	[navController release];
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // my view
    self.view.backgroundColor = [UIColor grayColor];
    
    // initial control
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGRect rect = CGRectMake(0, height - width, width, width);
    self.firstPattern = [GCPatternPasscodeViewController patternControlWithFrame:rect];
    [self.firstPattern
     addTarget:self
     action:@selector(patternControlValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.firstPattern];
    
}

@end
