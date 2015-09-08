//
//  DetailViewController.m
//  Homepwner
//
//  Created by luckytantanfu on 8/26/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface DetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UITextFieldDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePickerPopover;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@end

@implementation DetailViewController

#pragma mark - ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
  iv.contentMode = UIViewContentModeScaleAspectFit;
  iv.translatesAutoresizingMaskIntoConstraints = NO;

  [self.view addSubview:iv];
  self.imageView = iv;

  [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
  [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];

  NSDictionary *nameMap = @{
      @"imageView" : self.imageView,
      @"dateLabel" : self.dateLabel,
      @"toolbar" : self.toolbar
  };

  NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:nameMap];
  NSArray *vertiaclConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolbar]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
  [self.view addConstraints:horizontalConstraints];
  [self.view addConstraints:vertiaclConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  [self prepareViewsForOrientation:orientation];

  BNRItem *item = self.item;
  self.nameField.text = item.itemName;
  self.serialNumberField.text = item.serialNumber;
  self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

  static NSDateFormatter *dateFormatter = nil;
  if (!dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
  }

  self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];

  NSString *itemKey = self.item.itemKey;
  UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
  self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  // 取消当前的第一响应对象
  [self.view endEditing:YES];

  BNRItem *item = self.item;
  item.itemName = self.nameField.text;
  item.serialNumber = self.serialNumberField.text;
  item.valueInDollars = [self.valueField.text intValue];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  @throw [NSException exceptionWithName:@"Wrong initializer"
                                 reason:@"Use initForNewItem:"
                               userInfo:nil];
  return nil;
}

- (instancetype)initForNewItem:(BOOL)isNew {
  self = [super initWithNibName:nil bundle:nil];

  if (self) {
    if (isNew) {
      UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(save:)];
      self.navigationItem.rightBarButtonItem = doneItem;

      UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancel:)];
      self.navigationItem.leftBarButtonItem = cancelItem;
    }
  }

  return self;
}

- (void)setItem:(BNRItem *)item {
  _item = item;
  self.navigationItem.title = _item.itemName;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self prepareViewsForOrientation:toInterfaceOrientation];
}

#pragma mark Target-Action

- (IBAction)backgroundTapped:(id)sender {
  [self.view endEditing:YES];
}

- (IBAction)takePicture:(id)sender {
  if ([self.imagePickerPopover isPopoverVisible]) {
    [self.imagePickerPopover dismissPopoverAnimated:YES];
    self.imagePickerPopover = nil;
    return;
  }
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  } else {
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  }

  [imagePicker setAllowsEditing:YES];
  imagePicker.delegate = self;

  if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    self.imagePickerPopover.delegate = self;
    [self.imagePickerPopover presentPopoverFromBarButtonItem:sender
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
  } else {
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = info[UIImagePickerControllerEditedImage];

  [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];

  self.imageView.image = image;

  if (self.imagePickerPopover) {
    [self.imagePickerPopover dismissPopoverAnimated:YES];
    self.imagePickerPopover = nil;
  } else {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  NSLog(@"User dismissed popover");
  self.imagePickerPopover = nil;
}

#pragma mark - Helper

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation {
  if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    return;
  }

  if (UIInterfaceOrientationIsLandscape(orientation)) {
    self.imageView.hidden = YES;
    self.cameraButton.enabled = NO;
  } else {
    self.imageView.hidden = NO;
    self.cameraButton.enabled = YES;
  }
}

- (void)save:(id)save {
  [self.presentingViewController dismissViewControllerAnimated:YES
                                                    completion:self.dismissBlock];
}

- (void)cancel:(id)cancel {
  [[BNRItemStore sharedStore] removeItem:self.item];
  [self.presentingViewController dismissViewControllerAnimated:YES
                                                    completion:self.dismissBlock];
}
@end
