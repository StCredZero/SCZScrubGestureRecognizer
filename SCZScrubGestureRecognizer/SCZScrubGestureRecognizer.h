//
//  SCZScrubGestureRecognizer.h
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

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface SCZScrubGestureRecognizer : UIGestureRecognizer

@property (assign, nonatomic) NSUInteger minimumTouchesThreshold;
@property (assign, nonatomic) NSUInteger maximumTouchesThreshold;

@property (assign, nonatomic) NSUInteger horizontalThreshold;
@property (assign, nonatomic) NSUInteger verticalThreshold;

@property (readonly, assign, nonatomic) NSComparisonResult horizontalResult;
@property (readonly, assign, nonatomic) NSComparisonResult verticalResult;

@property (readonly, assign, nonatomic) CGPoint lastPoint;
@property (readonly, assign, nonatomic) NSUInteger touchCount;

@end
