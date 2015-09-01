//
//  FTDrawView.m
//  TouchTracker
//
//  Created by luckytantanfu on 8/30/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "FTDrawView.h"
#import "FTLine.h"

@interface FTDrawView ()

@property(nonatomic, strong) NSMutableDictionary *linesInProgress;
@property(nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation FTDrawView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.linesInProgress = [[NSMutableDictionary alloc] init];
    self.finishedLines = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor grayColor];

    self.multipleTouchEnabled = YES;

    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(doubleTap:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.delaysTouchesBegan = YES;
    [self addGestureRecognizer:doubleTapRecognizer];
  }

  return self;
}

- (void)doubleTap:(UIGestureRecognizer *)gesture {
  NSLog(@"Recognized Double Tap");

  [self.linesInProgress removeAllObjects];
  [self.finishedLines removeAllObjects];
  [self setNeedsDisplay];
}

- (void)strokeLine:(FTLine *)line {
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  bezierPath.lineWidth = 10;
  bezierPath.lineCapStyle = kCGLineCapRound;

  [bezierPath moveToPoint:line.begin];
  [bezierPath addLineToPoint:line.end];
  [bezierPath stroke];
}

- (void)drawRect:(CGRect)rect {
  [[UIColor blackColor] set];
  for (FTLine *line in self.finishedLines) {
    [self strokeLine:line];
  }

  [[UIColor redColor] set];
  for (NSValue *key in self.linesInProgress) {
    [self strokeLine:self.linesInProgress[key]];
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInView:self];
    FTLine *line = [[FTLine alloc] init];
    line.begin = location;
    line.end = location;

    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    self.linesInProgress[key] = line;
  }
  [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *touch in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    FTLine *line = self.linesInProgress[key];
    line.end = [touch locationInView:self];
  }
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *touch in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    FTLine *line = self.linesInProgress[key];
    [self.finishedLines addObject:line];
    [self.linesInProgress removeObjectForKey:key];
  }
  [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *touch in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    [self.linesInProgress removeObjectForKey:key];
  }
  [self setNeedsDisplay];
}


@end
