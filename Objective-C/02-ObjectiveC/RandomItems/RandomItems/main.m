//
//  main.m
//  RandomItems
//
//  Created by luckytantanfu on 8/3/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
//#import "BNRContainer.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];

        for (int i = 0; i < 10; i++) {
            BNRItem *item = [BNRItem randomItem];
            [items addObject:item];
        }

        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }

//        BNRContainer *container = [BNRContainer randomItem];
//        NSLog(@"container: %@", container);
//        BNRItem *item1 = [BNRItem randomItem];
//        BNRItem *item2 = [BNRItem randomItem];
//
//        NSLog(@"item1: %@", item1);
//        NSLog(@"item2: %@", item2);
//
//        [container addItem:item1];
//        [container addItem:item2];
//
//        NSLog(@"container contains item1 and item2 %@", container);
//
//        BNRContainer *subContainer = [BNRContainer randomItem];
//        [subContainer addItem:[BNRItem randomItem]];
//        [subContainer addItem:[BNRItem randomItem]];
//        NSLog(@"subContainer: %@", subContainer);
//
//        [container addItem:subContainer];
//        NSLog(@"container: %@", container);
        items = nil;
    }
    return 0;
}
