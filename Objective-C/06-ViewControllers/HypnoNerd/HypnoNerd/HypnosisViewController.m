//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by luckytantanfu on 8/11/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@interface HypnosisViewController ()

@property HypnosisView *backgroundView;

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
    self.backgroundView = [[HypnosisView alloc] init];
    self.view = self.backgroundView;

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"red", @"green", @"blue"]];

    [segmentedControl addTarget:self
                         action:@selector(segmentSelected:)
               forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:segmentedControl];
}

- (void)segmentSelected:(UISegmentedControl *)segmentSelected {
    NSLog(@"clicked %d", segmentSelected.selectedSegmentIndex);
    switch (segmentSelected.selectedSegmentIndex) {
        case 0:
            self.backgroundView.circleColor = [UIColor redColor];
            break;
        case 1:
            self.backgroundView.circleColor = [UIColor greenColor];
            break;
        case 2:
            self.backgroundView.circleColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"HypnosisViewController loaded its view.");
}


@end
