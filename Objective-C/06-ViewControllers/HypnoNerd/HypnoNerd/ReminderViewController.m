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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = image;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ReminderViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}


- (IBAction)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Hypnotize me!";
    notification.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


@end
