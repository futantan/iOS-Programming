//
//  BNRItemStore.h
//  Homepwner
//
//  Created by luckytantanfu on 8/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;

@end
