//
// UIViewController(Transaction).m
//
//  Created by Vitalii Bogdan on 19/05/2015 .
//  Copyright (c) 2015. All rights reserved.

#import <objc/runtime.h>
#import "UIViewController+Transition.h"
#import "JHModalTransitionManager.h"
#import "NSObject+Swizzling.h"

static NSString * kPresentationTransition = @"kPresentationTransition";
static NSMutableDictionary * _presentationTransitionManagers = nil;

@implementation UIViewController (Transition)

+ (void)initialize {
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        [[UIViewController class] changedMethodWithOriginalSelector:@selector(presentViewController:animated:completion:)
                                    newSelector:@selector(swizzled_presentViewController:animated:completion:)];
    });
}


+ (JHModalTransitionManager *)defaultPresentationTransitions {
    if ( _presentationTransitionManagers ) {

        Class clazz = self.class;
        JHModalTransitionManager * manager = nil;

        while ( clazz ) {
            NSString * key = [NSString stringWithFormat:@"%@", NSStringFromClass(clazz)];
            if ( _presentationTransitionManagers[key] ) {
                manager = [_presentationTransitionManagers[key] isKindOfClass:[NSNull class]] ? nil : _presentationTransitionManagers[key];
                break;
            }
            clazz = [clazz superclass];
        }

        return manager;
    }
    return nil;
}


+ (void)setDefaultPresentationTransitions:(JHModalTransitionManager *)presentationTransitionManager {

    if ( !_presentationTransitionManagers ) {
        _presentationTransitionManagers = [NSMutableDictionary dictionary];
    }

    NSString * key = [NSString stringWithFormat:@"%@", NSStringFromClass(self.class)];

    if ( presentationTransitionManager ) {
        _presentationTransitionManagers[key] = presentationTransitionManager;
    } else {
        _presentationTransitionManagers[key] = [NSNull null];
    }
}


- (JHModalTransitionManager *)presentationTransitions {
    JHModalTransitionManager * result = objc_getAssociatedObject(self, &kPresentationTransition);
    if ( !result ) {
        //this original manager
        JHModalTransitionManager * manager = [[self class] defaultPresentationTransitions];
        if ( manager ) {
            //copy manager
            result = [manager copy];
            [self setPresentationTransitions:result];
        }
    }
    return result;
}


- (void)setPresentationTransitions:(JHModalTransitionManager *)presentationTransitions {
    objc_setAssociatedObject(self, &kPresentationTransition, presentationTransitions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - swizzled -

- (void)swizzled_presentViewController:(UIViewController *)viewControllerToPresent
                              animated:(BOOL)animated
                            completion:(void (^)(void))completion {

    UIViewController * controller = (id) self;

    BOOL isExcludeClasses = [viewControllerToPresent isKindOfClass:[UIAlertController class]];

    if ( viewControllerToPresent.presentationTransitions && !isExcludeClasses ) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
        viewControllerToPresent.transitioningDelegate = self.presentationTransitions;
    }

    [controller swizzled_presentViewController:viewControllerToPresent
                                animated:animated
                              completion:completion];
}

@end