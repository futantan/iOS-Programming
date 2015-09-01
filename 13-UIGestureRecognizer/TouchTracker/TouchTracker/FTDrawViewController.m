//
//  FTDrawViewController.m
//  TouchTracker
//
//  Created by luckytantanfu on 8/30/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "FTDrawViewController.h"
#import "FTDrawView.h"

@interface FTDrawViewController ()

@end

@implementation FTDrawViewController

- (void)loadView {
  self.view = [[FTDrawView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}


@end
