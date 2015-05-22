//
// NSObject(Swizzling).m
//
//  Created by Vitalii Bogdan on 21/05/2015 .
//  Copyright (c) 2015. All rights reserved.

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)

+ (void)changedMethodWithOriginalSelector:(SEL)originalSelector newSelector:(SEL)newSelector {

    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);

    class_addMethod(self,
            newSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod));

    method_exchangeImplementations(originalMethod, class_getInstanceMethod(self, newSelector));
}

@end