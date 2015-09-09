//
//  BNRItem.m
//  RandomItems
//
//  Created by luckytantanfu on 8/4/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "BNRItem.h"
#import "BNRImageStore.h"

@implementation BNRItem

+ (instancetype)randomItem {
  NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];

  NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];

  NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
  NSInteger nounIndex = arc4random() % [randomNounList count];

  NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                                                    randomAdjectiveList[adjectiveIndex],
                                                    randomNounList[nounIndex]];

  int randomValue = arc4random() % 100;

  NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                                            '0' + arc4random() % 10,
                                                            'A' + arc4random() % 26,
                                                            '0' + arc4random() % 10,
                                                            'A' + arc4random() % 26,
                                                            '0' + arc4random() % 10];

  BNRItem *newItem = [[self alloc] initWithItemName:randomName
                                     valueInDollars:randomValue
                                       serialNumber:randomSerialNumber];
  return newItem;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
  self = [super init];
  if (self) {
    _itemName = name;
    _valueInDollars = value;
    _serialNumber = sNumber;
    _dateCreated = [[NSDate alloc] init];

    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    _itemKey = key;
  }

  return self;
}

- (instancetype)initWithItemName:(NSString *)name {
  return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (void)setThumbnailFromImage:(UIImage *)image {
  CGSize origImageSize = image.size;
  // 缩略图大小
  CGRect newRect = CGRectMake(0, 0, 40, 40);
  // 确定缩放倍数并保持宽高比不变
  float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
  // 根据当前设备的屏幕scaling factor创建透明的位图上下文
  UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
  // 创建表示圆角矩形的UIBezierPath对象
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:0.5];
  // 根据UIBezierPath对象裁剪图形上下文
  [path addClip];

  // 让图片在缩略图绘制范围内居中
  CGRect projectRect;
  projectRect.size.width = ratio * origImageSize.width;
  projectRect.size.height = ratio * origImageSize.height;
  projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
  projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;

  // 在上下文中绘制图片
  [image drawInRect:projectRect];

  // 通过图形上下文得到UIImage对象，并将其赋给thumbnail属性
  UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
  self.thumbnail = smallImage;

  // 清理图形上下文
  UIGraphicsEndImageContext();
}


- (instancetype)init {
  return [self initWithItemName:@"Item"];
}

- (void)dealloc {
  NSLog(@"Destroyed: %@", self);
}

- (NSString *)description {
  NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                                                 self.itemName,
                                                                 self.serialNumber,
                                                                 self.valueInDollars,
                                                                 self.dateCreated];
  return descriptionString;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.itemName forKey:@"itemName"];
  [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
  [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
  [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
  [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
  [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

- (id)initWithCoder:(NSCoder *)aCoder {
  self = [super init];
  if (self) {
    _itemName = [aCoder decodeObjectForKey:@"itemName"];
    _serialNumber = [aCoder decodeObjectForKey:@"serialNumber"];
    _dateCreated = [aCoder decodeObjectForKey:@"dateCreated"];
    _itemKey = [aCoder decodeObjectForKey:@"itemKey"];
    _thumbnail = [aCoder decodeObjectForKey:@"thumbnail"];
    _valueInDollars = [aCoder decodeIntForKey:@"valueInDollars"];
  }
  return self;
}


@end
