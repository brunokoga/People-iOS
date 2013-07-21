//
//  PeopleInitialViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleInitialViewController.h"
#import "PeoplePreferences.h"

@interface PeopleInitialViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *logoPlusPhraseView;
@property (weak, nonatomic) IBOutlet UIImageView *phraseImageView;

@end

@implementation PeopleInitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadFirstViewController];
}

- (void)adjustUIElements
{
    [self.logoPlusPhraseView setCenter:self.view.center];
}
/*
 This method will call:
    - PeopleTutorialViewController - if it's the first time that the app is launched
    - PeopleLoginViewController - if the user has logged out
    - PeopleSearchViewController - if the user has already logged in
 */

static NSString * const kLoginSegueIdentifier = @"Login Segue";
static NSString * const kTutorialSegueIdentifier = @"Tutorial Segue";
static NSString * const kSearchSegueIdentifier = @"Search Segue";


- (void)loadFirstViewController
{
    NSString *segueIdentifier = kLoginSegueIdentifier;
    /*
    BOOL isRunningForTheFirstTime = [PeoplePreferences isRunningForTheFirstTime];
    if (isRunningForTheFirstTime)
    {
        segueIdentifier = @"Tutorial Segue";
        
    } else {
        BOOL isAutoLoginOn = [PeoplePreferences isAutoLoginOn];
        if (isAutoLoginOn)
        {
            segueIdentifier = @"Search Segue";
        }
    }
     */
 
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

- (void)performTransitionWithSegueIdentifier:(NSString *)identifier
                                  completion:(void (^)(void))completion
{
    if ([identifier isEqualToString:kLoginSegueIdentifier])
    {
        [self transitionToLoginWithCompletion:completion];
    }
    else if ([identifier isEqualToString:kTutorialSegueIdentifier])
    {
        [self transitionToTutorialWithCompletion:completion];
    }
    else if ([identifier isEqualToString:kSearchSegueIdentifier])
    {
        [self transitionToSearchWithCompletion:completion];
    }
    
}

- (void)transitionToLoginWithCompletion:(void (^)(void))completion
{
    CGPoint convertedCenter = [self.view convertPoint:self.logoImageView.center toView:nil];
    CGPoint newLogoCenter = CGPointMake(convertedCenter.x, convertedCenter.y - self.view.frame.size.height/4);
    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.phraseImageView setAlpha:0.0];
                         [self.logoImageView setCenter:newLogoCenter];
                     } completion:^(BOOL finished) {
                         [self.phraseImageView removeFromSuperview];
                         completion();
                     }];
}

- (void)transitionToTutorialWithCompletion:(void (^)(void))completion
{
    
}

- (void)transitionToSearchWithCompletion:(void (^)(void))completion
{
    
}

@end
