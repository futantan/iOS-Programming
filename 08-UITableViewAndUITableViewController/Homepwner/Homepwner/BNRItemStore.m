//
//  BNRItemStore.m
//  Homepwner
//
//  Created by luckytantanfu on 8/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (NSArray *)itemsValueMoreThan50 {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (BNRItem *item in _privateItems) {
        if ([item valueInDollars] > 50) {
            [items addObject:item];
        }
    }
    return items;
}

- (NSArray *)itemsValueNoMoreThan50 {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (BNRItem *item in _privateItems) {
        if ([item valueInDollars] <= 50) {
            [items addObject:item];
        }
    }
    return items;
}


@end
