//
// UINavigationController(Transition).h
//

#import <Foundation/Foundation.h>

@class JHNavigationTransitionManager;

@interface UINavigationController (Transition)

+ (JHNavigationTransitionManager *)defaultNavigationTransitions;
+ (void)setDefaultNavigationTransitions:(JHNavigationTransitionManager *)navigationTransitionManager;

@property (nonatomic, strong) JHNavigationTransitionManager * navigationTransitions;

@end