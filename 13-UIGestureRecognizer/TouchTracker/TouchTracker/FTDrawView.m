//
//  FTDrawView.m
//  TouchTracker
//
//  Created by luckytantanfu on 8/30/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "FTDrawView.h"
#import "FTLine.h"

@interface FTDrawView () <UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
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

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                             action:@selector(longPress:)];
    [self addGestureRecognizer:longPressGestureRecognizer];

    self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(moveLine:)];
    self.moveRecognizer.delegate = self;
    self.moveRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:self.moveRecognizer];
  }

  return self;
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

#pragma mark - Gesture Selector

- (void)doubleTap:(UIGestureRecognizer *)gesture {
  NSLog(@"Recognized Double Tap");

  [self.linesInProgress removeAllObjects];
  [self.finishedLines removeAllObjects];
  [self setNeedsDisplay];
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

- (void)longPress:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint point = [gestureRecognizer locationInView:self];
    self.selectedLine = [self lineAtPoint:point];

    if (self.selectedLine) {
      [self.linesInProgress removeAllObjects];
    }
  } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
    self.selectedLine = nil;
  }
  [self setNeedsDisplay];
}

- (void)moveLine:(UIPanGestureRecognizer *)gestureRecognizer {
  UIMenuController *menuController = [UIMenuController sharedMenuController];
  if (menuController.isMenuVisible) {
    [menuController setMenuVisible:NO animated:NO];
    self.selectedLine = nil;
  }

  if (!self.selectedLine) {
    return;
  }


  if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
    CGPoint translation = [gestureRecognizer translationInView:self];
    CGPoint begin = self.selectedLine.begin;
    CGPoint end = self.selectedLine.end;
    begin.x += translation.x;
    begin.y += translation.y;
    end.x += translation.x;
    end.y += translation.y;

    self.selectedLine.begin = begin;
    self.selectedLine.end = end;

    [self setNeedsDisplay];

    [gestureRecognizer setTranslation:CGPointZero inView:self];
  }
}

#pragma mark - helper

- (void)strokeLine:(FTLine *)line {
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  bezierPath.lineWidth = 10;
  bezierPath.lineCapStyle = kCGLineCapRound;

  [bezierPath moveToPoint:line.begin];
  [bezierPath addLineToPoint:line.end];
  [bezierPath stroke];
}

- (void)deleteLine:(id)deleteLine {
  [self.finishedLines removeObject:self.selectedLine];
  [self setNeedsDisplay];
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

#pragma mark - TouchEvent

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"%@", NSStringFromSelector(_cmd));
  NSLog(@"hello");

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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  if (gestureRecognizer == self.moveRecognizer) {
    return YES;
  }
  return NO;
}


@end
