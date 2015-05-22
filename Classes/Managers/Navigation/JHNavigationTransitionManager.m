//
//  JHNavigationTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/6/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHNavigationTransitionManager.h"

@interface JHNavigationTransitionManager ()

@end

@implementation JHNavigationTransitionManager

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    MustOverride();
}

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    MustOverride();
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ( self.transitionType == TransitionTypePresent ) {
        return 1.0;
    } else {
        return 0.4;
    }
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    JHNavigationTransitionManager * navTransitionManager = self;
    if ( navTransitionManager ) {
        switch (operation) {
            case UINavigationControllerOperationPush:
                navTransitionManager.transitionType = TransitionTypePresent;
                return navTransitionManager;
            case UINavigationControllerOperationPop:
                navTransitionManager.transitionType = TransitionTypeDismiss;
                return navTransitionManager;
            default:
                return nil;
        }
    } else {
        return nil;
    }
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {

    // IMPLEMENT LATER

    return nil;
}

@end
