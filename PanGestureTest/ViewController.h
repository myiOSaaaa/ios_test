//
//  ViewController.h
//  PanGestureTest
//
//  Created by t-inagaki on 2015/03/21.
//  Copyright (c) 2015年 イナガキ タカシ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLayer.h"

@interface ViewController : UIViewController{
@private
CustomLayer *panlayer;
CGPoint beganpoint;
CGPoint centerpoint;
}

@property (nonatomic,retain) IBOutlet UIView *shuffleView;

- (void)handleTapGesture:(UITapGestureRecognizer *)sender;
- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)sender;
- (void)handleDoubleTouchGesture:(UITapGestureRecognizer *)sender;
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender;
- (void)handleRotationGesture:(UIRotationGestureRecognizer *)sender;

- (void)initShuffleView;
- (void)centeringShuffleCards;
- (void)scatteringShuffleCards;
- (void)changingColorShuffleCards;

@end

