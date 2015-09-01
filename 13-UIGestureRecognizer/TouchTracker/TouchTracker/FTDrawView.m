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
@property(nonatomic, weak) FTLine *selectedLine;

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

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tap:)];
    tapGestureRecognizer.delaysTouchesBegan = YES;
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    [self addGestureRecognizer:tapGestureRecognizer];
  }

  return self;
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer {
  NSLog(@"Recognized tap");

  CGPoint point = [gestureRecognizer locationInView:self];
  self.selectedLine = [self lineAtPoint:point];

  if (self.selectedLine) {

    // 使视图成为 UIMenuItem 动作消息的目标
    [self becomeFirstResponder];

    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
    menuController.menuItems = @[deleteItem];

    [menuController setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
    [menuController setMenuVisible:YES animated:YES];
  } else {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
  }

  [self setNeedsDisplay];
}

- (void)deleteLine:(id)deleteLine {
  [self.finishedLines removeObject:self.selectedLine];
  [self setNeedsDisplay];
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

  if (self.selectedLine) {
    [[UIColor greenColor] set];
    [self strokeLine:self.selectedLine];
  }
}

- (FTLine *)lineAtPoint:(CGPoint)point {
  for (FTLine *line in self.finishedLines) {
    CGPoint start = line.begin;
    CGPoint end = line.end;

    for (float t = 0.0; t <= 1.0; t += 0.05) {
      float x = start.x + t * (end.x - start.x);
      float y = start.y + t * (end.y - start.y);

      if (hypot(x - point.x, y - point.y) < 20.0) {
        return line;
      }
    }
  }
  return nil;
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

- (BOOL)canBecomeFirstResponder {
  return YES;
}


@end
