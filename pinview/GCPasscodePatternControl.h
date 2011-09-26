//
//  GridView.h
//  Pattern
//
//  Created by Caleb Davenport on 9/23/11.
//  Copyright 2011 GUI Cocoa, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GCPasscodePatternControlColorWhite,
    GCPasscodePatternControlColorGreen,
    GCPasscodePatternControlColorRed,
} GCPasscodePatternControlColor;

@interface GCPasscodePatternControl : UIControl

@property (nonatomic, assign) GCPasscodePatternControlColor color;

- (NSString *)patternString;
- (void)clearPattern;

@end
