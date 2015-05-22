//
//  JHTransitionManager.h
//  CustomViewControllerTransitionsExample
//
//  Created by Jeff Hurray on 9/4/14.
//  Copyright (c) 2014 jhurray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define MustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionTypePresent,
    TransitionTypeDismiss
};

@interface JHTransitionManager : NSObject <UIViewControllerAnimatedTransitioning, NSCopying>

@property(nonatomic, assign) TransitionType transitionType;

- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext;

- (void)animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext;

@end
