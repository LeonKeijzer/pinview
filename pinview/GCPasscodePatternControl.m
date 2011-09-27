//
//  GridView.m
//  Pattern
//
//  Created by Caleb Davenport on 9/23/11.
//  Copyright 2011 GUI Cocoa, LLC. All rights reserved.
//

#import "GCPasscodePatternControl.h"

// dimensions (compile constants for now)
#define kDotSize 40.0
#define kNumberOfRows 3
#define kNumberOfColumns 3

@interface GCPasscodePatternControl ()

// the single touch to be used for tracking
@property (nonatomic, retain) UITouch *touch;

// an array of points that represent touch targets
@property (nonatomic, retain) NSArray *points;

// array of indices for objects in the points array
@property (nonatomic, retain) NSMutableArray *pattern;

// update the pattern array
- (void)updatePattern;

// generate the dot rects given a point
+ (CGRect)innerDotRectForPoint:(CGPoint)point;
+ (CGRect)outerDotRectForPoint:(CGPoint)point;

// color utilities
+ (CGColorRef)greenColor;
+ (CGColorRef)whiteColor;
+ (CGColorRef)redColor;
+ (CGColorRef)translucentBlackColor;
+ (CGColorRef)translucentWhiteColor;

@end

@implementation GCPasscodePatternControl

@synthesize touch = __touch;
@synthesize points = __points;
@synthesize pattern = __pattern;
@synthesize color = __color;

#pragma mark - class methods
+ (CGRect)innerDotRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - kDotSize / 2.0,
                      point.y - kDotSize / 2.0,
                      kDotSize,
                      kDotSize);
}
+ (CGRect)outerDotRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - kDotSize,
                      point.y - kDotSize,
                      kDotSize * 2.0,
                      kDotSize * 2.0);
}
+ (CGColorRef)greenColor {
    static CGColorRef color = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        color = [[UIColor greenColor] CGColor];
        CGColorRetain(color);
    });
    return color;
}
+ (CGColorRef)whiteColor {
    static CGColorRef color = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        color = [[UIColor whiteColor] CGColor];
        CGColorRetain(color);
    });
    return color;
}
+ (CGColorRef)redColor {
    static CGColorRef color = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        color = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor];
        CGColorRetain(color);
    });
    return color;
}
+ (CGColorRef)translucentBlackColor {
    static CGColorRef color = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        color = [[UIColor colorWithWhite:0.0 alpha:0.6] CGColor];
        CGColorRetain(color);
    });
    return color;
}
+ (CGColorRef)translucentWhiteColor {
    static CGColorRef color = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        color = [[UIColor colorWithWhite:1.0 alpha:0.8] CGColor];
        CGColorRetain(color);
    });
    return color;
}

#pragma mark - object methods
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.color = GCPasscodePatternControlColorWhite;
    }
    return self;
}
- (void)dealloc {
    self.touch = nil;
    self.points = nil;
    self.pattern = nil;
    [super dealloc];
}
- (void)updatePattern {
    CGPoint location = [self.touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        NSInteger row = location.y / (self.bounds.size.width / (CGFloat)kNumberOfRows);
        NSInteger column = location.x / (self.bounds.size.height / (CGFloat)kNumberOfColumns);
        NSInteger index = row * kNumberOfRows + column;
        if (index >= 0 && index < [self.points count]) {
            CGPoint point = [[self.points objectAtIndex:index] CGPointValue];
            CGRect rect = [GCPasscodePatternControl outerDotRectForPoint:point];
            if (CGRectContainsPoint(rect, location)) {
                NSNumber *number = [NSNumber numberWithInteger:index];
                if (![self.pattern containsObject:number]) {
                    [self.pattern addObject:number];
                }
            }
        }
    }
}
- (NSString *)patternString {
    NSMutableString *pattern = [NSMutableString stringWithCapacity:[self.pattern count]];
    [self.pattern enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [pattern appendFormat:@"%lu", [obj unsignedIntegerValue]];
    }];
    return pattern;
}
- (void)clearPattern {
    self.pattern = nil;
    [self setNeedsDisplay];
}
- (void)setColor:(GCPasscodePatternControlColor)color {
    if (color == __color) { return; }
    __color = color;
    [self setNeedsDisplay];
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat gridWidth = self.bounds.size.width / (CGFloat)kNumberOfColumns;
    CGFloat gridHeight = self.bounds.size.height / (CGFloat)kNumberOfRows;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:(kNumberOfRows * kNumberOfColumns)];
    for (NSUInteger i = 0; i < kNumberOfRows; i++) {
        for (NSUInteger j = 0; j < kNumberOfColumns; j++) {
            CGPoint point = CGPointMake(gridWidth * (CGFloat)j + gridWidth / 2.0, gridHeight * (CGFloat)i + gridHeight / 2.0);
            [array addObject:[NSValue valueWithCGPoint:point]];
        }
    }
    self.points = array;
    [self setNeedsDisplay];
}

#pragma mark - drawing
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // setup context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // draw lines
    CGContextSetLineWidth(context, kDotSize);
    CGContextSetStrokeColorWithColor(context, [GCPasscodePatternControl translucentWhiteColor]);
    NSUInteger count = [self.pattern count];
    if (count > 0) {
        NSUInteger index = [[self.pattern objectAtIndex:0] unsignedIntegerValue];
        CGPoint point = [[self.points objectAtIndex:index] CGPointValue];
        CGContextMoveToPoint(context, point.x, point.y);
        for (NSUInteger i = 1; i < count; i++) {
            index = [[self.pattern objectAtIndex:i] unsignedIntegerValue];
            point = [[self.points objectAtIndex:index] CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        if (self.touch) {
            CGPoint location = [self.touch locationInView:self];
            CGContextAddLineToPoint(context, location.x, location.y);
        }
    }
    CGContextStrokePath(context);
    
    // draw points
    CGContextSetLineWidth(context, 5.0);
    [self.points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = [obj CGPointValue];
        CGRect outerRect = [GCPasscodePatternControl outerDotRectForPoint:point];
        CGContextSetFillColorWithColor(context, [GCPasscodePatternControl translucentBlackColor]);
        CGContextFillEllipseInRect(context, outerRect);
        if (self.color == GCPasscodePatternControlColorRed) {
            CGContextSetFillColorWithColor(context, [GCPasscodePatternControl redColor]);
        }
        else if (self.color == GCPasscodePatternControlColorGreen) {
            CGContextSetFillColorWithColor(context, [GCPasscodePatternControl greenColor]);
        }
        else {
            CGContextSetFillColorWithColor(context, [GCPasscodePatternControl whiteColor]);
        }
        CGContextFillEllipseInRect(context, [GCPasscodePatternControl innerDotRectForPoint:point]);
        if (count > 0) {
            NSNumber *index = [NSNumber numberWithUnsignedInteger:idx];
            if ([[self.pattern objectAtIndex:0] isEqualToNumber:index]) {
                if (self.color == GCPasscodePatternControlColorRed) {
                    CGContextSetStrokeColorWithColor(context, [GCPasscodePatternControl redColor]);
                }
                else {
                    CGContextSetStrokeColorWithColor(context, [GCPasscodePatternControl greenColor]);
                }
                CGContextStrokeEllipseInRect(context, outerRect);
            }
        }
    }];
}

#pragma mark - touch handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touch == nil) {
        self.touch = [touches anyObject];
        self.pattern = [NSMutableArray array];
        [self updatePattern];
        self.color = GCPasscodePatternControlColorWhite;
        [self setNeedsDisplay];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches containsObject:self.touch]) {
        [self updatePattern];
        [self setNeedsDisplay];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches containsObject:self.touch]) {
        self.touch = nil;
        [self clearPattern];
        [self setNeedsDisplay];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches containsObject:self.touch]) {
        self.touch = nil;
        if ([self.pattern count]) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
        [self setNeedsDisplay];
    }
}

@end
