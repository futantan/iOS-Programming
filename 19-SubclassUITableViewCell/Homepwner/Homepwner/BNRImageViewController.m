//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by luckytantanfu on 9/10/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@end

@implementation BNRImageViewController

- (void)loadView {
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIImageView *imageView = (UIImageView *)self.view;
  imageView.image = self.image;
}

@end
