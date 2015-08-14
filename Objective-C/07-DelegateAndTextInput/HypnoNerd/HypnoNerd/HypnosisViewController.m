//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by luckytantanfu on 8/11/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@interface HypnosisViewController () <UITextFieldDelegate>

@end

@implementation HypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
    }

    return self;
}

- (void)loadView {
    HypnosisView *backgroundView = [[HypnosisView alloc] init];

    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];

    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;

    textField.delegate = self;

    [backgroundView addSubview:textField];
    self.view = backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"HypnosisViewController loaded its view.");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message {
    for (int i = 0; i < 20; ++i) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];

        int width = (int) (self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        int height = (int) (self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;

        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;

        [self.view addSubview:messageLabel];
    }
}


@end
