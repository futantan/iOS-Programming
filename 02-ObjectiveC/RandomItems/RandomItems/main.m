//
//  main.m
//  RandomItems
//
//  Created by luckytantanfu on 8/3/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];

//        for (int i = 0; i < 10; i++) {
//            BNRItem *item = [BNRItem randomItem];
//            [items addObject:item];
//        }

        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];

        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];

        backpack.containedItem = calculator;

        backpack = nil;
        calculator = nil;

        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }

        NSLog(@"Setting items to nil");
        items = nil;
        NSLog(@"end");
    }
    return 0;
}
