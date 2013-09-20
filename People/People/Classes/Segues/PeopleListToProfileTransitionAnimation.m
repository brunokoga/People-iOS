//
//  PeopleListToProfileTransitionAnimation.m
//  People
//
//  Created by Bruno Koga on 9/8/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleListToProfileTransitionAnimation.h"
#import "PeopleSearchViewController.h"
#import "PeopleProfileViewController.h"
#import "PeopleSearchTableViewCell.h"


//TODO: refactor that. Use actual values
#define kPICTURE_FRAME CGRectMake(10.0f, 25.0f, 50.0f, 50.0f)
#define kPHONE1_FRAME CGRectMake(20.0f, -137, 160, 30)
#define kPHONE2_FRAME CGRectMake(161.0f, -147.0f, 160.0f, 50.0f)
#define kNAME_FRAME CGRectMake(0.0f, -130.0f, 280.0f, 50.0f)
#define kROLE_FRAME CGRectMake(0.0f, -110.0f, 280.0f, 50.0f)

@implementation PeopleListToProfileTransitionAnimation

// transition duration.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromViewController isKindOfClass:[PeopleSearchViewController class]])
    {
        [self animateForwardTransition:transitionContext];
    } else if ([fromViewController isKindOfClass:[PeopleProfileViewController class]])
    {
        [self animateBackwardTransition:transitionContext];
    }
    
}

- (void)animateForwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    BOOL forward = YES;
    [self animateTransition:transitionContext forward:forward];
    
    /*
     All this code below should be deleted as soon as the method
     - (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext forward:(BOOL)forward
     is correctly implemented
     
     To implement it, we need to remove the common logic from the methods
     - (void)animateForwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
     - (void)animateBackwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
     
     This is a code scenario to use OCMock, Unit Tests and Refactoring/Design Patterns
     */
    
    PeopleSearchViewController *fromViewController = (PeopleSearchViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PeopleProfileViewController *toViewController = (PeopleProfileViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *transitionView = [transitionContext containerView];
    [transitionView addSubview:toViewController.view];
    toViewController.view.alpha = 0.0f;
    
    UIView *toViewControllerContentView = toViewController.contentView;
    UIColor *oldBackgroundColor = toViewController.scrollView.backgroundColor;
    toViewController.scrollView.backgroundColor = [UIColor clearColor];
    [toViewControllerContentView removeFromSuperview];
    [transitionView addSubview:toViewControllerContentView];
    toViewControllerContentView.frame = [fromViewController.view convertRect:[fromViewController selectedCellRelativeFrame]
                                                                    toView:transitionView];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        toViewController.view.alpha = 1.0f;
    }];
    
    void (^animationBlock)(void) = ^{
        toViewControllerContentView.frame =
        [toViewController.view convertRect:[toViewController frameForContainerView]
                                    toView:transitionView];
        toViewController.scrollView.backgroundColor = oldBackgroundColor;
        
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [toViewControllerContentView removeFromSuperview];

        toViewControllerContentView.frame = toViewController.containerView.bounds;
        [toViewController.containerView addSubview:toViewControllerContentView];
        
        [transitionContext completeTransition:YES];
    };

    CGRect pictureFrame = kPICTURE_FRAME;
    CGRect phone1Frame = kPHONE1_FRAME;
    CGRect phone2Frame = kPHONE2_FRAME;
    CGRect nameFrame = kNAME_FRAME;
    CGRect roleFrame = kROLE_FRAME;
    
    [toViewController performListToProfileAnimationWithDuration:[self transitionDuration:transitionContext]/2
                                                   pictureFrame:pictureFrame
                                                    phone1Frame:phone1Frame
                                                    phone2Frame:phone2Frame
                                                      nameFrame:nameFrame
                                                      roleFrame:roleFrame];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:10.0
                        options:0
                     animations:animationBlock
                     completion:completionBlock];

}

- (void)animateBackwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    BOOL forward = NO;
    [self animateTransition:transitionContext forward:forward];
    
    /*
     All this code below should be deleted as soon as the method
     - (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext forward:(BOOL)forward
     is correctly implemented
     
     To implement it, we need to remove the common logic from the methods
     - (void)animateForwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
     - (void)animateBackwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext
     
     This is a code scenario to use OCMock, Unit Tests and Refactoring/Design Patterns
     */
    
    PeopleProfileViewController *fromViewController = (PeopleProfileViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PeopleSearchViewController *toViewController = (PeopleSearchViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    [transitionView addSubview:toViewController.view];
    toViewController.view.alpha = 0.0f;
    
    UIView *fromViewControllerContentView = fromViewController.contentView;
    [fromViewControllerContentView removeFromSuperview];
    [transitionView addSubview:fromViewControllerContentView];
    PeopleSearchTableViewCell *selectedCell = [toViewController selectedCell];
    selectedCell.alpha = 0.0f;
    fromViewControllerContentView.frame = [fromViewController.view convertRect:[fromViewController frameForContainerView]
                                                                        toView:transitionView];

            toViewController.view.alpha = 1.0f;
    [UIView animateWithDuration:0.2 animations:^{
        
        fromViewController.view.alpha = 0.0f;
    }];
    
    void (^animationBlock)(void) = ^{
        CGRect frame = [toViewController.view convertRect:[toViewController selectedCellRelativeFrame]
                                                   toView:transitionView];
        fromViewControllerContentView.frame = frame;
        [fromViewController.scrollView setBackgroundColor:[UIColor clearColor]];
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [fromViewControllerContentView removeFromSuperview];
        [fromViewController.view addSubview:fromViewControllerContentView];
        selectedCell.alpha = 1.0f;
        
        [transitionContext completeTransition:YES];
    };
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.0
                        options:0
                     animations:animationBlock
                     completion:completionBlock];
    
    //TODO: change that!!
    CGRect pictureFrame = kPICTURE_FRAME;
    CGRect phone1Frame = kPHONE1_FRAME;
    CGRect phone2Frame = kPHONE2_FRAME;
    CGRect nameFrame = kNAME_FRAME;
    CGRect roleFrame = kROLE_FRAME;
    
    
    [fromViewController performProfileToListAnimationWithDuration:[self transitionDuration:transitionContext]
                                                     pictureFrame:pictureFrame
                                                      phone1Frame:phone1Frame
                                                      phone2Frame:phone2Frame
                                                        nameFrame:nameFrame
                                                        roleFrame:roleFrame];

     

    
}


// if !forward then its backward
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext forward:(BOOL)forward
{
    
}



@end
