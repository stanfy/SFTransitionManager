//
// NSObject(Swizzling).h
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)changedMethodWithOriginalSelector:(SEL)originalSelector newSelector:(SEL)newSelector;

@end