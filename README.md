# SFTransitionManager

Custom animation transition manager


Install
------

Using CocoaPods

```
pod 'SFTransitionManager', :git => 'https://github.com/stanfy/SFTransitionManager.git', :tag => '0.0.1'
```

Using
-----

#####Global properties:

In AppDelegate add the following lines of code with whatever transition object you want. This will determine the animations that will be used as default.
``` objective-c
[UIViewController setDefaultPresentationTransitions:[JHPullBackModalTransitionManager new]];
[UINavigationController setDefaultNavigationTransitions:[JHDropDownNavigationTransitionManager new]];
//don't set a modal transition to 'RMDateSelectionViewController'
[SFMainViewController setDefaultPresentationTransitions:nil];
```

#####Controller properties:

``` objective-c
UIViewController * viewController = [UIViewController new];
viewController.presentationTransitions = [JHPullBackModalTransitionManager new];
```

``` objective-c
UINavigationController * navigationController = [UINavigationController new];
navigationController.navigationTransitions = [JHDropDownNavigationTransitionManager new];
```
##Additional Animations:

To create a custom modal or navigation animation subclass JHModalTransitionManager and JHNavigationTransitionManager respectively.  

Then, override the following methods:  

```objective-c
- (void)animatePresentTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
   //TODO
}

- (void) animateDismissTransitionFrom:(UIViewController *)fromVC to:(UIViewController *)toVC withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    //TODO
}
```

Also override:

```objective-c
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.transitionType == TransitionTypePresent) { // push and present
        return 1.0;
    } else { // dismissing and popping
        return 0.4;
    }
}
```
to set the animation duration. 

##Built-in Transitions

#####Navigation:
+ JHNavigationTransitionTypeZoom
+ JHNavigationTransitionTypeDropDown

#####Modal:
+ JHModalTransitionTypeBounceUp
+ JHModalTransitionTypePullBack
