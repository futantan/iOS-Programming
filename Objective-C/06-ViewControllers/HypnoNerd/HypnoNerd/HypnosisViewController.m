//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by luckytantanfu on 8/11/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

- (void)loadView {
    HypnosisView *backgroundView = [[HypnosisView alloc] init];
    self.view = backgroundView;
}

@end
