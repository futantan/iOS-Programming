//
//  DetailViewController.h
//  Homepwner
//
//  Created by luckytantanfu on 8/26/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, strong) BNRItem *item;

@end
