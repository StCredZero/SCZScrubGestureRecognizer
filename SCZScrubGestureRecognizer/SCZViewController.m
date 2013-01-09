//
//  SCZViewController.m
//  SCZScrubGestureRecognizer
//
//  Created by Peter Suk on 1/8/13.
//  Copyright (c) 2013 StCredZero. All rights reserved.
//

#import "SCZViewController.h"
#import "SCZScrubGestureRecognizer.h"

static NSInteger currentImageNumber = 0;

@interface SCZViewController ()

@end

@implementation SCZViewController

@synthesize imageView = _imageView;
@synthesize images = _images;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGSize mySize;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        mySize = CGSizeMake(320.0, 320.0);
    }
    else {
        mySize = CGSizeMake(768.0, 768.0);
    }
    
    CGPoint myCenter = self.view.center;
    CGRect myBounds = self.view.bounds;
    myBounds.size = mySize;
    self.imageView.bounds = myBounds;
    self.imageView.center = myCenter;
    
    NSMutableArray *myImages = [NSMutableArray new];
    for (NSUInteger i = 1; i <= 32; i++) {
        NSString *file = [NSString stringWithFormat:@"pov-%d.png", i];
        UIImage *image = [UIImage imageNamed:file];
        [myImages addObject:image];
    }
    _images = myImages;
    
    if (self.images && [self.images count] > 0) {
        [self loadImageNumber:0];
    }
    SCZScrubGestureRecognizer *recognizer =
    [[SCZScrubGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(handleScrub:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImageNumber:(NSUInteger)imageNumber
{
    self.imageView.image = [self.images objectAtIndex:imageNumber];
}

- (void)loadCurrentImage
{
    [self loadImageNumber:currentImageNumber];
}

- (void)handleScrub:(UIGestureRecognizer *)sender {
    SCZScrubGestureRecognizer *recognizer = (SCZScrubGestureRecognizer*)sender;
    switch (recognizer.state) {
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            switch (recognizer.horizontalResult) {
                case NSOrderedDescending: {
                    currentImageNumber = (currentImageNumber + 1) % [self.images count];
                    [self loadCurrentImage];
                }
                    break;
                case NSOrderedAscending: {
                    currentImageNumber = (currentImageNumber - 1) % [self.images count];
                    [self loadCurrentImage];
                }
                    break;
                default:
                    break;
            }
        } break;
        case UIGestureRecognizerStatePossible: {
            
        } break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded: {
        }
    }
}


@end
