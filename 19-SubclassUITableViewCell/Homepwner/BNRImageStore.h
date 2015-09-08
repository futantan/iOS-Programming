//
//  BNRImageStore.h
//  Homepwner
//
//  Created by luckytantanfu on 8/27/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (id)initPrivate;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;

- (UIImage *)imageForKey:(NSString *)key;

- (void)deleteImageForKey:(NSString *)key;

- (NSString *)imagePathForKey:(NSString *)key;

@end
