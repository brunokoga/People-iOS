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

- (void)alignUIElements
{
    [super alignUIElements];
    [self.logoImageView setCenter:self.view.center];
}
/*
 This method will call:
    - PeopleTutorialViewController - if it's the first time that the app is launched
    - PeopleLoginViewController - if the user has logged out
    - PeopleSearchViewController - if the user has already logged in
 */
- (void)loadFirstViewController
{
    NSString *segueIdentifier = @"Login Segue";
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
 
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

- (void)performInitialAnimationWithCompletion:(void(^)(void))completion
{
  
    [UIView animateWithDuration:5.0 animations:^{
        CGPoint logoNewCenter = CGPointMake(self.view.center.x, self.view.center.y/3);
        [self.logoImageView setCenter:logoNewCenter];
        
    } completion:^(BOOL finished) {
        completion();
    }];
}

@end
