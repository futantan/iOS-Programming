//
//  BNRItemStore.m
//  Homepwner
//
//  Created by luckytantanfu on 8/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
  static BNRItemStore *sharedStore = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      sharedStore = [[self alloc] initPrivate];
  });
  return sharedStore;
}

- (BNRItem *)createItem {
  BNRItem *item = [[BNRItem alloc] init];
  [self.privateItems addObject:item];
  return item;
}

- (void)removeItem:(BNRItem *)item {
  NSString *key = item.itemKey;
  [[BNRImageStore sharedStore] deleteImageForKey:key];

  [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  if (fromIndex == toIndex) {
    return;
  }
  BNRItem *item = self.privateItems[fromIndex];

  [self.privateItems removeObjectAtIndex:fromIndex];
  [self.privateItems insertObject:item atIndex:toIndex];
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
    NSString *path = [self itemArchivePath];
    _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!_privateItems) {
      _privateItems = [[NSMutableArray alloc] init];
    }
  }
  return self;
}

- (NSArray *)allItems {
  return self.privateItems;
}

- (NSString *)itemArchivePath {
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentDirectory = [documentDirectories firstObject];
  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
  NSString *path = [self itemArchivePath];
  return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}
@end
