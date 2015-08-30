//
//  FTDrawView.m
//  TouchTracker
//
//  Created by luckytantanfu on 8/30/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "FTDrawView.h"
#import "FTLine.h"

@interface FTDrawView()

@property (nonatomic, strong) FTLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation FTDrawView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.finishedLines = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor grayColor];
  }

  return self;
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

  if (self.currentLine) {
    [[UIColor redColor] set];
    [self strokeLine:self.currentLine];
  }
}


@end
