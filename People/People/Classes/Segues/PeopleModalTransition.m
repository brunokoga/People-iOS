//
//  PeopleModalTransition.m
//  People
//
//  Created by Bruno Koga on 9/24/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleModalTransition.h"

@interface PeopleModalTransition ()
@end

@implementation PeopleModalTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting) {
        [self animatePresentationTransition:transitionContext];
    } else {
        [self animateDismissalTransition:transitionContext];
    }
}

- (void)animatePresentationTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = (UIViewController *)
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController *)
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    toViewController.view.frame = CGRectZero;
    toViewController.view.center = fromViewController.view.center;
    [transitionView addSubview:toViewController.view];

    void (^animationBlock)(void) = ^{

        toViewController.view.frame = fromViewController.view.frame;
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    };
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:15.0
                        options:0
                     animations:animationBlock
                     completion:completionBlock];

}

- (void)animateDismissalTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = (UIViewController *)
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController *)
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    [transitionView addSubview:toViewController.view];
    [transitionView addSubview:fromViewController.view];
//    toViewController.view.alpha = 0.0f;
    
    void (^animationBlock)(void) = ^{
        fromViewController.view.frame = CGRectMake(toViewController.view.center.x,
                                         toViewController.view.center.y,
                                         0, 0);
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    };
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10.0
                        options:0
                     animations:animationBlock
                     completion:completionBlock];

}

@end
