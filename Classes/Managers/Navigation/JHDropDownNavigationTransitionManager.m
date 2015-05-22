//
//  JHDropDownNavigationTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/11/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHDropDownNavigationTransitionManager.h"

@implementation JHDropDownNavigationTransitionManager

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIView *containerView = [transitionContext containerView];
    CGRect toEndFrame = fromVC.view.frame;
    CGRect toStartFrame = CGRectMake(0, -screenSize.height, screenSize.width, screenSize.height);
    toVC.view.frame = toStartFrame;
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:0 animations:^{
        [toVC.view setFrame:toEndFrame];
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIView *containerView = [transitionContext containerView];
    CGRect fromEndFrame = CGRectMake(0, -screenSize.height, screenSize.width, screenSize.height);
    toVC.view.frame = fromVC.view.frame;
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [fromVC.view setFrame:fromEndFrame];
    }                completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ( self.transitionType == TransitionTypePresent ) {
        return 1.0;
    } else {
        return 0.4;
    }
}

@end
