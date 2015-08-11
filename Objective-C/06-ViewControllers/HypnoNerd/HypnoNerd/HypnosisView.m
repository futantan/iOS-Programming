//
//  HypnosisView.m
//  Hypnosister
//
//  Created by luckytantanfu on 8/9/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView ()
@property (strong, nonatomic) UIColor *circleColor;
@end

@implementation HypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }

    return self;
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched", self);

    float red = (float) ((arc4random() % 100) / 100.0);
    float green = (float) ((arc4random() % 100) / 100.0);
    float blue = (float) ((arc4random() % 100) / 100.0);

    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;

    CGPoint center;
    center.x = (CGFloat) (bounds.origin.x + bounds.size.width / 2.0);
    center.y = (CGFloat) (bounds.origin.y + bounds.size.height / 2.0);

    float maxRadius = (float) (hypot(bounds.size.width, bounds.size.height) / 2.0);

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
    [self.circleColor setStroke];

    [path stroke];
}

@end
