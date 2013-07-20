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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (void)performInitialAnimationTransitioningToViewController:(UIViewController *)destinationViewController
                                              withIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kLoginSegueIdentifier])
    {
        [self transitionToLoginViewController:destinationViewController];
    }
    else if ([identifier isEqualToString:kTutorialSegueIdentifier])
    {
        [self transitionToTutorialViewController:destinationViewController];
    }
    else if ([identifier isEqualToString:kSearchSegueIdentifier])
    {
        [self transitionToSearchViewController:destinationViewController];
    }
    
}

- (void)transitionToLoginViewController:(UIViewController *)destinationViewController
{
    CGPoint convertedCenter = [self.view convertPoint:self.logoImageView.center toView:nil];
    CGPoint newLogoCenter = CGPointMake(convertedCenter.x, convertedCenter.y - 100);
    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.phraseImageView setAlpha:0.0];
                         [self.logoImageView setCenter:newLogoCenter];
                     } completion:^(BOOL finished) {
                         [self.phraseImageView removeFromSuperview];
                         [self.navigationController setViewControllers:@[destinationViewController]];
                     }];

    
}

- (void)transitionToTutorialViewController:(UIViewController *)destinationViewController
{
    
}

- (void)transitionToSearchViewController:(UIViewController *)destinationViewController
{
    
}

@end
