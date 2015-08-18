//
//  ItemsViewController.m
//  Homepwner
//
//  Created by luckytantanfu on 8/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"


@implementation ItemsViewController

- (instancetype)init {
    // 在新的指定初始化方法中调用父类的指定初始化方法
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; ++i) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    // 覆盖父类的指定初始化，调用新的指定初始化方法
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark UITableViewDataSource

// 练习： 分为2组 大于50美元和小于50美元的
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *allItems = [[BNRItemStore sharedStore] allItems];
    int numOfMoreThan50 = (int)[[[BNRItemStore sharedStore] itemsValueMoreThan50] count];

    if (section == 0) {
        return numOfMoreThan50;
    } else {
        return [allItems count] - numOfMoreThan50;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"more than 50";
    }
    else {
        return @"no more than 50";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    BNRItem *item;
    if (indexPath.section == 0) {
        item = [[BNRItemStore sharedStore] itemsValueMoreThan50][indexPath.row];
    } else {
        item = [[BNRItemStore sharedStore] itemsValueNoMoreThan50][indexPath.row];
    }

    cell.textLabel.text = [item description];
    return cell;
}

@end
