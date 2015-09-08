//
//  BNRImageStore.m
//  Homepwner
//
//  Created by luckytantanfu on 8/27/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore
+ (instancetype)sharedStore {
  static BNRImageStore *sharedStore = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      sharedStore = [[self alloc] initPrivate];
  });
  return sharedStore;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [BNRImageStore sharedStore]"
                               userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    _dictionary = [[NSMutableDictionary alloc] init];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(clearCache:)
                               name:UIApplicationDidReceiveMemoryWarningNotification
                             object:nil];
  }
  return self;
}

- (void)clearCache:(NSNotification *)note {
  NSLog(@"flushing %d images out of the cache", [self.dictionary count]);
  [self.dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
  self.dictionary[key] = image;
  NSString *imagePath = [self imagePathForKey:key];
  NSData *data = UIImageJPEGRepresentation(image, 0.5);
  [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key {
  // 首先尝试通过字典对象获取图片
  UIImage *result = self.dictionary[key];
  // 如果字典中不存在，从文件中加载
  if (!result) {
    NSString *imagePath = [self imagePathForKey:key];
    result = [UIImage imageWithContentsOfFile:imagePath];
    // 从文件中加载之后，将其存入字典，作为缓存
    if (result) {
      self.dictionary[key] = result;
    } else {
      NSLog(@"key:%@", key);
      NSLog(@"Error: unable to find %@", [self imagePathForKey:key]);
    }
  }
  return result;
}

- (void)deleteImageForKey:(NSString *)key {
  if (!key) {
    return;
  }
  [self.dictionary removeObjectForKey:key];
  NSString *imagePath = [self imagePathForKey:key];
  [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key {
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentDirectory = [documentDirectories firstObject];
  return [documentDirectory stringByAppendingPathComponent:key];
}


@end
