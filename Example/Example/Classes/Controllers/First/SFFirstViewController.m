//
// SFFirstViewController.m
//
//  Created by Vitalii Bogdan on 25/05/2015 .
//  Copyright (c) 2015. All rights reserved.

#import "SFFirstViewController.h"

@interface SFFirstViewController ()

@end

@implementation SFFirstViewController

- (id)init {
    self = [super init];
    if ( self ) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];

    self.title = @"Modal Controller";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneAction)];
}


- (void)doneAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end