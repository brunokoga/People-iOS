//
//  PeopleNavigationControllerDelegate.m
//  People
//
//  Created by Bruno Koga on 9/8/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleNavigationControllerDelegate.h"
#import "PeopleListToProfileTransitionAnimation.h"
#import "PeopleSearchViewController.h"
#import "PeopleProfileViewController.h"

@implementation PeopleNavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    id <UIViewControllerAnimatedTransitioning> animator = nil;
    
    if ([fromVC isKindOfClass:[PeopleSearchViewController class]] &&
        [toVC isKindOfClass:[PeopleProfileViewController class]])
    {
        [navigationController setNavigationBarHidden:NO animated:YES];
        animator = [PeopleListToProfileTransitionAnimation new];
        
    } else if ([fromVC isKindOfClass:[PeopleProfileViewController class]] &&
               [toVC isKindOfClass:[PeopleSearchViewController class]])
    {
        [navigationController setNavigationBarHidden:YES animated:YES];
        animator = [PeopleListToProfileTransitionAnimation new];
    }
    
    return animator;
}
/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[PeopleSearchViewController class]])
    {

    } else if ([viewController isKindOfClass:[PeopleProfileViewController class]])
    {

    }
}
 */

@end
