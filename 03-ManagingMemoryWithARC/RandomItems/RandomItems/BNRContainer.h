//
//  BNRContainer.h
//  RandomItems
//
//  Created by luckytantanfu on 8/4/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem {
    NSMutableArray *_subitems;
}

- (void)addItem:(BNRItem *)item;
@end
