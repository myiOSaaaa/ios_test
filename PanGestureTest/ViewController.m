//
//  ViewController.m
//  PanGestureTest
//
//  Created by t-inagaki on 2015/03/21.
//  Copyright (c) 2015年 イナガキ タカシ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


static const NSInteger CardsNumber = 9;

static const NSInteger ShuffleCardWidth = 80;
static const NSInteger ShuffleCardHeight = 80;
static const NSInteger ShuffleCardWidthHalf = 40;
static const NSInteger ShuffleCardHeightHalf = 40;

static NSString *CardImageTemplate = @"card%@-80.png";
static NSString * CardImageColor[] = {@"white",@"black",@"blue",@"green",@"red",@"yellow"};

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        shuffleView_ = nil;
        panlayer = nil;
        beganpoint = CGPointZero;
        centerpoint = CGPointZero;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initShuffleView];
    
    self.shuffleView.userInteractionEnabled = YES;
    self.shuffleView.multipleTouchEnabled = YES;
    
    UITapGestureRecognizer *g1;
    UITapGestureRecognizer *g2;
    UITapGestureRecognizer *g3;
    UIPanGestureRecognizer *gp;
    UIRotationGestureRecognizer *gr;
    
    g1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    g2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    g2.numberOfTapsRequired = 2;
    [g1 requireGestureRecognizerToFail:g2];
    g3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTouchGesture:)];
    g3.numberOfTouchesRequired = 2;
    gp = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    gr = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    [self.shuffleView addGestureRecognizer:g1];
    [self.shuffleView addGestureRecognizer:g2];
    [self.shuffleView addGestureRecognizer:g3];
    [self.shuffleView addGestureRecognizer:gp];
    [self.shuffleView addGestureRecognizer:gr];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
 //   [self scatteringShuffleCards];
    CGPoint loc = [sender locationInView:self.shuffleView];
    CALayer *blayer = [self.shuffleView.layer hitTest:loc];
//    if([blayer.name isEqualToString:@"circle"]){
//        return;
//    }
    if (blayer.name == nil) {
        self->panlayer.borderWidth = 0.0;
        self->panlayer = nil;
        self->beganpoint = CGPointZero;
        self->centerpoint = CGPointZero;
    }
    else {
        self->panlayer = blayer;
        self->beganpoint = loc;
        self->centerpoint = blayer.position;
        self->panlayer.borderColor = [UIColor redColor].CGColor;
        self->panlayer.borderWidth = 2.0;
//        self->panlayer.transform = CATransform3DMakeScale(.65, .65, 1);
    }


}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)sender
{
//    [self changingColorShuffleCards];
}

- (void)handleDoubleTouchGesture:(UITapGestureRecognizer *)sender
{
    [self centeringShuffleCards];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
//    CGPoint loc = [sender locationInView:self.shuffleView];
    NSLog(@"sender=%@",sender);

//    CGPoint loc = [sender locationInView:self.shuffleView];
//    CALayer *blayer = [self.shuffleView.layer hitTest:loc];

//    if(self->panlayer == nil){
//        return;
//    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint loc = [sender locationInView:self.shuffleView];
        CALayer *blayer = [self.shuffleView.layer hitTest:loc];
        if([blayer.name isEqualToString:@"circle"]){
            return;
        }
        
        if (blayer.name == nil) {
            self->panlayer = nil;
            self->beganpoint = CGPointZero;
            self->centerpoint = CGPointZero;
        }
        else {
            self->panlayer = blayer;
            self->beganpoint = loc;
            self->centerpoint = blayer.position;
        }
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
//        [sender locationInView:<#(UIView *)#>]
        CGPoint loc = [sender locationInView:self.shuffleView];
        
        CALayer *blayer = [self.shuffleView.layer hitTest:loc];
        if([blayer.name isEqualToString:@"circle"]){
            blayer.superlayer.frame = CGRectMake(loc.x + 25, loc.y+25,
                                                 blayer.superlayer.frame.size.width,
                                                 blayer.superlayer.frame.size.height);
            return;
        }

        NSLog(@"sender=%@",sender);
        if (self->panlayer) {
            self->panlayer.position = loc;
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint tloc = [sender translationInView:self.shuffleView];
        CGPoint loc = CGPointMake(self->beganpoint.x + tloc.x, self->beganpoint.y + tloc.y);
        if (self->panlayer) {
            if ([self.shuffleView pointInside:loc withEvent:nil]) {
                self->panlayer.position = loc;
            }
            else {
                self->panlayer.position = self->centerpoint;
            }
        }
        self->panlayer.borderWidth = 0.0;
        self->panlayer = nil;
        self->beganpoint = CGPointZero;
        self->centerpoint = CGPointZero;
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)sender
{
    NSNumber *rval = [NSNumber numberWithFloat:sender.rotation];
    for (CALayer *l in self.shuffleView.layer.sublayers) {
        [l setValue:rval forKeyPath:@"transform.rotation"];
    }
}

- (void)initShuffleView
{
    NSString *imagecolor = @"white";
    NSString *imagename = [NSString stringWithFormat:CardImageTemplate,imagecolor];
    UIImage *image = [UIImage imageNamed:@"s.jpg"];
    NSLog(@"%@",NSStringFromCGSize(image.size));
    CGRect shcardRect = CGRectMake(0.0, 0.0, (CGFloat)ShuffleCardWidth, (CGFloat)ShuffleCardHeight);
    CGPoint shcardCenter = CGPointMake(self.shuffleView.bounds.size.width / 2.0, self.shuffleView.bounds.size.height / 2.0);
    for (NSInteger i = 0; i < CardsNumber; i++) {
        CustomLayer *layer = [CustomLayer layer];
        layer.name = [NSString stringWithString:imagecolor];
        layer.bounds = shcardRect;
        layer.position = shcardCenter;
        layer.contents = (id)image.CGImage;
        [self.shuffleView.layer addSublayer:layer];
        NSLog(@"layer.frame.size.width=%f",layer.frame.size.width);
//        [layer test];
    }
}

- (void)centeringShuffleCards
{
    CGPoint shcardCenter = CGPointMake(self.shuffleView.bounds.size.width / 2.0, self.shuffleView.bounds.size.height / 2.0);
    NSNumber *rval = [NSNumber numberWithFloat:0.0f];
    for (CALayer *l in self.shuffleView.layer.sublayers) {
        l.position = shcardCenter;
        [l setValue:rval forKeyPath:@"transform.rotation"];
    }
}
/*
- (void)scatteringShuffleCards
{
    NSUInteger rndxmax;
    NSUInteger rndymax;
    rndxmax = (int)floor(self.shuffleView.bounds.size.width) - ShuffleCardWidth;
    rndymax = (int)floor(self.shuffleView.bounds.size.height) - ShuffleCardHeight;
    for (CALayer *l in self.shuffleView.layer.sublayers) {
        CGPoint rndpoint = CGPointMake((CGFloat)[RandomUtil randomUnsignedInteger:rndxmax] + ShuffleCardWidthHalf,
                                       (CGFloat)[RandomUtil randomUnsignedInteger:rndymax] + ShuffleCardHeightHalf);
        l.position = rndpoint;
    }
}

- (void)changingColorShuffleCards
{
    NSUInteger colorcnt = sizeof(CardImageColor)/sizeof(NSString *);
    [self.shuffleView.layer.sublayers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSUInteger rc = [RandomUtil randomUnsignedInteger:colorcnt];
        NSString *ic = CardImageColor[rc];
        NSString *imagename = [NSString stringWithFormat:CardImageTemplate,ic];
        UIImage *image = [UIImage imageNamed:imagename];
        CALayer *layer = (CALayer *)obj;
        layer.name = [NSString stringWithString:ic];
        layer.contents = (id)image.CGImage;
    }];
}
 */
@end
