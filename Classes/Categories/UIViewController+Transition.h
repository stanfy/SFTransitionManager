//
// UIViewController(Transaction).h
//

#import <Foundation/Foundation.h>

@class JHModalTransitionManager;

@interface UIViewController (Transition)

+ (JHModalTransitionManager *)defaultPresentationTransitions;
+ (void)setDefaultPresentationTransitions:(JHModalTransitionManager *)navigationTransitionManager;

@property (nonatomic, strong) JHModalTransitionManager * presentationTransitions;

@end