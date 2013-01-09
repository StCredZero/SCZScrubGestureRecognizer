//
//  SCZScrubGestureRecognizer.m
//  SCZScrubGestureRecognizer
//
//  Created by Peter K. Suk on 1/6/13.
//  Copyright (c) 2013 Peter K. Suk. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SCZScrubGestureRecognizer.h"

#define kDefaultThreshold 10.0

@implementation SCZScrubGestureRecognizer

@synthesize minimumTouchesThreshold = _minimumTouchesThreshold;
@synthesize maximumTouchesThreshold = _maximumTouchesThreshold;

@synthesize horizontalThreshold = _horizontalThreshold;
@synthesize verticalThreshold = _verticalThreshold;

@synthesize lastPoint = _lastPoint;
@synthesize horizontalResult = _horizontalResult;
@synthesize verticalResult = _verticalResult;
@synthesize touchCount = _touchCount;

#pragma mark - Implementation

- (CGPoint)averageOfTouches:(NSSet*)touches
{
    CGPoint sum = CGPointMake(0.0,0.0);
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        sum.x += point.x;
        sum.y += point.y;
    }
    CGPoint avg = CGPointMake(sum.x / (CGFloat)[touches count], sum.y / (CGFloat)[touches count]);
    return avg;
}

- (void)registerTouches:(NSSet*)touches
{
    BOOL shouldResetLastPoint = NO;
    CGPoint current = [self averageOfTouches:touches];
    
    // Horizontal
    if (current.x > (_lastPoint.x + _horizontalThreshold)) {
        _horizontalResult = NSOrderedAscending;
        shouldResetLastPoint = YES;
    }
    else if (current.x < (_lastPoint.x - _horizontalThreshold)) {
        _horizontalResult = NSOrderedDescending;
        shouldResetLastPoint = YES;
    }
    else {
        _horizontalResult = NSOrderedSame;
    }
    
    // Vertical
    if (current.y > (_lastPoint.y + _verticalThreshold)) {
        _verticalResult = NSOrderedAscending;
        shouldResetLastPoint = YES;
    }
    else if (current.y < (_lastPoint.y - _verticalThreshold)) {
        _verticalResult = NSOrderedDescending;
        shouldResetLastPoint = YES;
    }
    else {
        _verticalResult = NSOrderedSame;
    }
    
    if (shouldResetLastPoint) {
        _lastPoint = current;
    }
}

#pragma mark - UIGestureRecognizer methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    switch (self.state) {
        case UIGestureRecognizerStatePossible: {
            _touchCount = [touches count];
            _lastPoint = [self averageOfTouches:touches];
            self.state = UIGestureRecognizerStateBegan;
        }
            break; // Do nothing. Must begin or end touches to change from this state
        default: {
            _touchCount += [touches count];
            [self registerTouches:touches];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self registerTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if ([touches count] >= _touchCount) {
        self.state = UIGestureRecognizerStateEnded;
    }
    else {
        _touchCount -= [touches count];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if ([touches count] >= _touchCount) {
        self.state = UIGestureRecognizerStateCancelled;
    }
    else {
        _touchCount -= [touches count];
    }
}

#pragma mark - Initialization/Reset

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    _horizontalResult = NSOrderedSame;
    _verticalResult = NSOrderedSame;
    self.horizontalThreshold = kDefaultThreshold;
    self.verticalThreshold = kDefaultThreshold;
    return self;
}

- (void)reset {
    [super reset];
    _horizontalResult = NSOrderedSame;
    _verticalResult = NSOrderedSame;
}

@end
