//
//  JHPullBackModalTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/11/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHPullBackModalTransitionManager.h"

@interface JHPullBackModalTransitionManager ()

@end

@implementation JHPullBackModalTransitionManager

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIView *containerView = [transitionContext containerView];
    CGRect toEndFrame = toVC.view.frame;
    CGRect toStartFrame = CGRectMake(0, screenBounds.size.height, screenBounds.size.width, screenBounds.size.height);
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    [toVC.view setFrame:toStartFrame];
    CGAffineTransform shrink = CGAffineTransformMakeScale(0.95, 0.95);
    CGAffineTransform shiftDown = CGAffineTransformMakeTranslation(0, 20);
    CGAffineTransform shrinkAndShift = CGAffineTransformConcat(shrink, shiftDown);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fromVC.view.transform = shrinkAndShift;
    }                completion:nil];
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [toVC.view setFrame:toEndFrame];
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *modalView = fromVC.view;
    UIView *modalSnapshot = [modalView snapshotViewAfterScreenUpdates:NO];
    modalSnapshot.frame = modalView.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:modalSnapshot];
    [containerView bringSubviewToFront:modalSnapshot];
    [modalView removeFromSuperview];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect toEndFrame = CGRectMake(0, screenBounds.size.height, screenBounds.size.width, screenBounds.size.height);
    CGAffineTransform grow = CGAffineTransformMakeScale(1.0, 1.0);

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [modalSnapshot setFrame:toEndFrame];
    }                completion:nil];
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.transform = grow;
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.7;
}

@end
