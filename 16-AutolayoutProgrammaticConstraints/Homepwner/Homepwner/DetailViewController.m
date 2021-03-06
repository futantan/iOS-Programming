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

@interface DetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation DetailViewController

- (IBAction)backgroundTapped:(id)sender {
  [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (IBAction)takePicture:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  } else {
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  }

  [imagePicker setAllowsEditing:YES];
  imagePicker.delegate = self;
  [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)setItem:(BNRItem *)item {
  _item = item;
  self.navigationItem.title = _item.itemName;
}

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = info[UIImagePickerControllerEditedImage];

  [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];

  self.imageView.image = image;
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
