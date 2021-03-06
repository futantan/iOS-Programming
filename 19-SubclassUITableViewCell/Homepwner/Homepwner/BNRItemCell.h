//
// Created by luckytantanfu on 9/8/15.
// Copyright (c) 2015 futantan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
