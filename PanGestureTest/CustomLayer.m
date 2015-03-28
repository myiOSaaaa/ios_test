//
//  CustomLayer.m
//  PanGestureTest
//
//  Created by t-inagaki on 2015/03/21.
//  Copyright (c) 2015年 イナガキ タカシ. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //india
        NSLog(@"%@",NSStringFromCGRect(self.bounds));

        CAShapeLayer * sl1 = [CAShapeLayer layer];
        
        UIBezierPath* circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, WIDTH, WIDTH)];
        
        //test test
        float img_w = 80.0;
        sl1.path = circle.CGPath;
        sl1.lineWidth = 2.0;
        sl1.name = @"circle";
        sl1.strokeColor = [UIColor redColor].CGColor;
        sl1.fillColor = [UIColor clearColor].CGColor;
        sl1.anchorPoint = CGPointMake(1.0,1.0);//アニメーションの中心点の設定
        sl1.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
        sl1.position = CGPointMake(0, 0);
        sl1.contentsScale=[[UIScreen mainScreen] scale];
//        sl1.rasterizationScale = [UIScreen mainScreen].scale;
//        sl1.shouldRasterize = YES;
        [self addSublayer:sl1];
        int i=0;
//sdfsadf
        CAShapeLayer * sl2 = [CAShapeLayer layer];
        
        sl2.path = circle.CGPath;
        sl2.name = @"circle";
        sl2.lineWidth = 2.0;
        sl2.strokeColor = [UIColor redColor].CGColor;
        sl2.fillColor = [UIColor clearColor].CGColor;
        sl2.anchorPoint = CGPointMake(0,1.0);//アニメーションの中心点の設定
        sl2.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
        sl2.position = CGPointMake(img_w, 0);
        sl2.contentsScale=[[UIScreen mainScreen] scale];
        //        sl1.rasterizationScale = [UIScreen mainScreen].scale;
        //        sl1.shouldRasterize = YES;
        [self addSublayer:sl2];

    }
    return self;
}

@end
