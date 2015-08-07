//
//  BNRContainer.m
//  RandomItems
//
//  Created by luckytantanfu on 8/4/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super initWithItemName:name valueInDollars:value serialNumber:sNumber];
    if (self) {
        _subitems = [[NSMutableArray alloc] init];
    }
    return self;
}


- (int)valueInDollars {
    int value = 0;
    for (BNRItem *item in _subitems) {
        value += item.valueInDollars;
    }
    return value + _valueInDollars;
}

- (NSString *)description {
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorede on %@",
                                                                   self.itemName,
                                                                   self.serialNumber,
                                                                   self.valueInDollars,
                                                                   self.dateCreated];
    return descriptionString;
}

- (void)addItem:(BNRItem *)item {
    [_subitems addObject:item];
}

@end
