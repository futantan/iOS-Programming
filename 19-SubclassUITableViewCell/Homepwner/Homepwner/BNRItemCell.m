//
// Created by luckytantanfu on 9/8/15.
// Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRItemCell.h"


@implementation BNRItemCell

- (IBAction)showImage:(id)sender {
  if (self.actionBlock) {
    self.actionBlock();
  }
}

@end