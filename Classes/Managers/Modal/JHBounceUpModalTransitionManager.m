//
//  JHBounceUpModalTransitionManager.m
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/8/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import "JHBounceUpModalTransitionManager.h"

@interface JHBounceUpModalTransitionManager ()

@property(nonatomic, strong) UIView *coverView;
@property(nonatomic, strong) NSArray *constraints;

@end

@implementation JHBounceUpModalTransitionManager

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];
    UIView *modalView = toVC.view;

    if ( !self.coverView ) {
        self.coverView = [[UIView alloc] initWithFrame:containerView.frame];
        self.coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.coverView.alpha = 0.0;
    } else {
        self.coverView.frame = containerView.frame;
    }
    // add cover view
    [containerView addSubview:self.coverView];

    //Using autolayout to position the modal view
    modalView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:modalView];
    NSDictionary *views = NSDictionaryOfVariableBindings(containerView, modalView);
    self.constraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[modalView]-30-|" options:0 metrics:nil views:views] arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[modalView]-30-|" options:0 metrics:nil views:views]];
    [containerView addConstraints:self.constraints];

    CGRect endFrame = modalView.frame;
    CGRect startFrame = modalView.frame;
    startFrame.origin.y = containerView.frame.size.height;
    modalView.frame = startFrame;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.coverView.alpha = 1.0;
        [modalView setFrame:endFrame];
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

    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.3 animations:^{
            modalSnapshot.transform = CGAffineTransformMakeTranslation(0, -30);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.5 animations:^{
            modalSnapshot.transform = CGAffineTransformMakeTranslation(0, 600);
            modalSnapshot.alpha = 0.0;
        }];
    }                         completion:^(BOOL finished) {
        [modalSnapshot removeFromSuperview];
        [containerView removeConstraints:self.constraints];
        [transitionContext completeTransition:YES];
    }];

}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ( self.transitionType == TransitionTypePresent ) {
        return 1.0;
    } else {
        return 0.8;
    }
}

@end
