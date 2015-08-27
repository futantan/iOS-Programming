//
// Created by luckytantanfu on 8/7/15.
// Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRPerson.h"


@implementation BNRPerson

- (void)setLastNameOfSpouse:(NSString *)lastNameOfSpouse {
    self.spouse.lastName = lastNameOfSpouse;
}

- (NSString *)lastNameOfSpouse {
    return self.spouse.lastName;
}

@end