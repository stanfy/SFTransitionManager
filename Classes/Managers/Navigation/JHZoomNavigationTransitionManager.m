//
//  JHZoomNavigationTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/11/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHZoomNavigationTransitionManager.h"

@interface JHZoomNavigationTransitionManager ()


@end


@implementation JHZoomNavigationTransitionManager


- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    [toVC.view setAlpha:0.0];
    toVC.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [toVC.view setAlpha:1.0];
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
        [fromVC.view setAlpha:0.0];
    }                completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


@end
