//
//  SFSecondViewController.m
//  Example
//
//  Created by Vitalii Bogdan on 5/25/15.
//  Copyright (c) 2015 Stanfy. All rights reserved.
//


#import "SFSecondViewController.h"


@interface SFSecondViewController ()

@end

@implementation SFSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Step #%d", [self.navigationController.viewControllers count] - 1];
    CGFloat redColor = (CGFloat) ((rand() % 255) / 255.0);
    CGFloat greenColor = (CGFloat) ((rand() % 255) / 255.0);
    CGFloat blueColor = (CGFloat) ((rand() % 255) / 255.0);
    self.view.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(nextAction)];
}


- (void)nextAction {
    SFSecondViewController * controller = [SFSecondViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end