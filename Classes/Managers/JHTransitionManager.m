//
//  JHTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/4/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHTransitionManager.h"

#define TRANSITION_DURATION 1.0

@interface JHTransitionManager ()

@end


@implementation JHTransitionManager

@synthesize transitionType;

#pragma mark - NSCopying -

- (id)copyWithZone:(NSZone *)zone {
    JHTransitionManager * manager = (JHTransitionManager *) [[self class] new];
    manager.transitionType = self.transitionType;
    return manager;
}


#pragma mark - UIViewControllerAnimatedTransitioning - 

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if ( transitionType == TransitionTypePresent ) {
        [self animatePresentTransitionFrom:fromVC to:toVC withTransitionContext:transitionContext];
    }
    else if ( transitionType == TransitionTypeDismiss ) {
        [self animateDismissTransitionFrom:fromVC to:toVC withTransitionContext:transitionContext];
    }
    else {
        NSAssert(FALSE, @"Custom transition type is nil!");
    }

}

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    MustOverride();
}

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    MustOverride();
}

@end
