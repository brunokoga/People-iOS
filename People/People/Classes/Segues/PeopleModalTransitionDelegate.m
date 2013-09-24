//
//  PeopleModalTransitionDelegate.m
//  People
//
//  Created by Bruno Koga on 9/24/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleModalTransitionDelegate.h"
#import "PeopleModalTransition.h"

@implementation PeopleModalTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    PeopleModalTransition *transition = [[PeopleModalTransition alloc] init];
    transition.isPresenting = YES;
    return transition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    PeopleModalTransition *transition = [[PeopleModalTransition alloc] init];
    transition.isPresenting = NO;
    return transition;
}
@end
