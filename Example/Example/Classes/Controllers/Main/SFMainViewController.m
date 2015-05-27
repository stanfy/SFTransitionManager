//
// SFMainViewController.m
//
//  Created by Vitalii Bogdan on 25/05/2015 .
//  Copyright (c) 2015. All rights reserved.

#import "SFMainViewController.h"
#import "SFFirstViewController.h"
#import "SFSecondViewController.h"
#import "UIViewController+Transition.h"
#import "JHModalTransitionManager.h"
#import "JHPullBackModalTransitionManager.h"
#import "JHBounceUpModalTransitionManager.h"
#import "UINavigationController+Transition.h"
#import "JHDropDownNavigationTransitionManager.h"
#import "JHZoomNavigationTransitionManager.h"

static NSInteger kPresentTransitionTag = 1;
static NSInteger kNavigationTransitionTag = 2;

@interface SFMainViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@end

@implementation SFMainViewController

- (id)init {
    self = [super init];
    if ( self ) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Example";

    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView reloadData];
}

#pragma mark - DataSource -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sfMenu"];

    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sfMenu"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView * backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor lightGrayColor];
        [cell setSelectedBackgroundView:backgroundView];
    }

    switch ( indexPath.row ) {
        case 0:
            cell.textLabel.text = @"Set Present Transition";
            break;
        case 1:
            cell.textLabel.text = @"Set Navigation Transition";
            break;
        case 2:
            cell.textLabel.text = @"Show Modal Controller";
            break;
        case 3:
            cell.textLabel.text = @"Push Controller";
            break;
        default:
            break;
    }

    return cell;
}


#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch ( indexPath.row ) {
        case 0:
            [self defaultPresentTransitionButtonAction];
            break;
        case 1:
            [self defaultNavigationTransitionButtonAction];
            break;
        case 2:
            [self showModalControllerButtonAction];
            break;
        case 3:
            [self pushControllerAction];
            break;
        default:
            break;
    }

}

#pragma mark - UIActionSheetDelegate -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ( actionSheet.tag == kPresentTransitionTag ) {
        if ( buttonIndex == 0 ) {
            [UIViewController setDefaultPresentationTransitions:[JHBounceUpModalTransitionManager new]];
        } else if ( buttonIndex == 1 ) {
            [UIViewController setDefaultPresentationTransitions:[JHPullBackModalTransitionManager new]];
        }

        //update transition in current controller
        self.presentationTransitions = [UIViewController defaultPresentationTransitions];
    } else {
        if ( buttonIndex == 0 ) {
            [UINavigationController setDefaultNavigationTransitions:[JHDropDownNavigationTransitionManager new]];
        } else if ( buttonIndex == 1 ) {
            [UINavigationController setDefaultNavigationTransitions:[JHZoomNavigationTransitionManager new]];
        }

        //update transition in current navigation controller
        self.navigationController.navigationTransitions = [UINavigationController defaultNavigationTransitions];
    }
}

#pragma mark - Actions -

- (void)defaultPresentTransitionButtonAction {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Animations"
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                       otherButtonTitles:@"Bounce Up", @"Pull Back",nil];
    actionSheet.tag = kPresentTransitionTag;
    [actionSheet showInView:self.view];
}


- (void)defaultNavigationTransitionButtonAction {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Animations"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Drop down", @"Zoom",nil];
    actionSheet.tag = kNavigationTransitionTag;
    [actionSheet showInView:self.view];
}


- (void)showModalControllerButtonAction {
    
    SFFirstViewController * firstController = [SFFirstViewController new];

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:firstController] animated:YES completion:nil];
    
}

- (void)pushControllerAction {

    SFSecondViewController * controller = [SFSecondViewController new];
    [self.navigationController pushViewController:controller animated:YES];

}
@end