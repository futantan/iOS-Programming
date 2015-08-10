//
//  HypnosisView.m
//  Hypnosister
//
//  Created by luckytantanfu on 8/9/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;

    CGPoint center;
    center.x = (CGFloat) (bounds.origin.x + bounds.size.width / 2.0);
    center.y = (CGFloat) (bounds.origin.y + bounds.size.height / 2.0);

    float maxRadius = (float) ((MIN(bounds.size.width, bounds.size.height)) / 2.0);

    UIBezierPath *path = [[UIBezierPath alloc] init];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:(CGFloat) (M_PI * 2.0)
                     clockwise:YES];
    }

    path.lineWidth = 10;
    [[UIColor lightGrayColor] setStroke];

    [path stroke];

    float imageHeight = 200;
    float imageWidth = 150;
    CGRect imageRect = CGRectMake(
            (CGFloat) ((bounds.size.width - imageWidth) / 2.0),
            (CGFloat) ((bounds.size.height - imageHeight) / 2.0),
            imageWidth,
            imageHeight);

    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:imageRect];
}

@end
