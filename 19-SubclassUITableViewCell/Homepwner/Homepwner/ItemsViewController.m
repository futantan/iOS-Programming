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
#import "BNRItemCell.h"
#import "BNRImageStore.h"
#import "BNRImageViewController.h"

@interface ItemsViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation ItemsViewController

- (IBAction)addNewItem:(id)sender {
  BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

  DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];
  detailViewController.item = newItem;
  detailViewController.dismissBlock = ^{
      [self.tableView reloadData];
  };

  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
  [self presentViewController:navigationController animated:YES completion:nil];
}

- (instancetype)init {
  // 在新的指定初始化方法中调用父类的指定初始化方法
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Homepwner";

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(addNewItem:)];
    navItem.rightBarButtonItem = barButtonItem;

    navItem.leftBarButtonItem = self.editButtonItem;
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  // 覆盖父类的指定初始化，调用新的指定初始化方法
  return [self init];
}

- (void)viewDidLoad {
  [super viewDidLoad];

//  [self.tableView registerClass:[UITableViewCell class]
//         forCellReuseIdentifier:@"UITableViewCell"];
  UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCell"];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.tableView reloadData];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];

  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *item = items[(NSUInteger) indexPath.row];

  cell.nameLabel.text = item.itemName;
  cell.serialNumberLabel.text = item.serialNumber;
  cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
  cell.thumbnailView.image = item.thumbnail;

  __weak BNRItemCell *weakCell = cell;

  cell.actionBlock = ^{
      NSLog(@"Going to show image for %@", item);

      BNRItemCell *strongCell = weakCell;
      if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        NSString *itemKey = item.itemKey;
        UIImage *image = [[BNRImageStore sharedStore] imageForKey:itemKey];
        if (!image) {
          return;
        }

        CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds fromView:strongCell.thumbnailView];
        BNRImageViewController *imageViewController = [[BNRImageViewController alloc] init];
        imageViewController.image = image;
        self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:imageViewController];
        self.imagePopover.delegate = self;
        self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
        [self.imagePopover presentPopoverFromRect:rect
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
      }
  };
  return cell;
}

#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    [[BNRItemStore sharedStore] removeItem:item];

    [tableView deleteRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
  [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Remove";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DetailViewController *detailViewController = [[DetailViewController alloc] init];
  DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];

  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *selectedItem = items[indexPath.row];

  detailViewController.item = selectedItem;

  [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  self.imagePopover = nil;
}

@end
