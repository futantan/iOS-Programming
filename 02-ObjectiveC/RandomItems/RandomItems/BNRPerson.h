//
// Created by luckytantanfu on 8/7/15.
// Copyright (c) 2015 futantan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BNRPerson : NSObject
@property (nonatomic, strong) BNRPerson *spouse;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *lastNameOfSpouse;
@end