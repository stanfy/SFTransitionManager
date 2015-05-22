//
// UINavigationController(Transition).m
//
//  Created by Vitalii Bogdan on 21/05/2015 .
//  Copyright (c) 2015. All rights reserved.

#import <objc/runtime.h>
#import "UINavigationController+Transition.h"
#import "JHNavigationTransitionManager.h"
#import "NSObject+Swizzling.h"

static NSString * kNavigationTransitions = @"navigationTransitions";
static NSMutableDictionary * _navigationTransitionManagers = nil;

@implementation UINavigationController (Transition)

+ (void)initialize {
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        [[UINavigationController class] changedMethodWithOriginalSelector:@selector(loadView) newSelector:@selector(swizzled_loadView)];
    });
}

+ (JHNavigationTransitionManager *)defaultNavigationTransitions {
    if ( _navigationTransitionManagers ) {

        Class clazz = self.class;
        JHNavigationTransitionManager * manager = nil;

        while ( clazz ) {
            NSString * key = [NSString stringWithFormat:@"%@", NSStringFromClass(clazz)];
            if ( _navigationTransitionManagers[key] ) {
                manager = [_navigationTransitionManagers[key] isKindOfClass:[NSNull class]] ? nil : _navigationTransitionManagers[key];
                break;
            }
            clazz = [clazz superclass];
        }

        return manager;
    }
    return nil;
}


+ (void)setDefaultNavigationTransitions:(JHNavigationTransitionManager *)navigationTransitionManager {
    if ( !_navigationTransitionManagers ) {
        _navigationTransitionManagers = [NSMutableDictionary dictionary];
    }

    NSString * key = [NSString stringWithFormat:@"%@", NSStringFromClass(self.class)];

    if ( navigationTransitionManager ) {
        _navigationTransitionManagers[key] = navigationTransitionManager;
    } else {
        _navigationTransitionManagers[key] = [NSNull null];
    }

}


- (JHNavigationTransitionManager *)navigationTransitions {
    JHNavigationTransitionManager * result = objc_getAssociatedObject(self, &kNavigationTransitions);
    if ( !result ) {
        JHNavigationTransitionManager * originalManager = [[self class] defaultNavigationTransitions];
        if ( originalManager ) {
            result = [originalManager copy];
            [self setNavigationTransitions:result];
        }
    }
    return result;
}


- (void)setNavigationTransitions:(JHNavigationTransitionManager *)navigationTransitions {
    objc_setAssociatedObject(self, &kNavigationTransitions, navigationTransitions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    self.delegate = navigationTransitions;
}


#pragma mark - swizzled -

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

- (void)swizzled_loadView {
    [self swizzled_loadView];

    if ( self.navigationTransitions ) {
        self.delegate = self.navigationTransitions;
    }
}

#pragma clang diagnostic pop

@end