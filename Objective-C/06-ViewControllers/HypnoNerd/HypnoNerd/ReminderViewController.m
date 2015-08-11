//
//  ReminderViewController.m
//  HypnoNerd
//
//  Created by luckytantanfu on 8/11/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation ReminderViewController

- (IBAction)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}

@end
