//
//  PeopleSearchViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchViewController.h"
#import "PeopleProfileViewController.h"

@interface PeopleSearchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundLogo;

@end

@implementation PeopleSearchViewController

#pragma mar - View Controller Lifecycle and Adjustments

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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)adjustUIElements
{
    [self.backgroundLogo setCenter:self.view.center];
}

static NSString * const kSearchToProfileSegue = @"Search To Profile Segue";

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSearchToProfileSegue])
    {
        PeopleProfileViewController *profileViewController = (PeopleProfileViewController *)segue.destinationViewController;
        profileViewController.colaborador = nil;
    }
    
}

- (IBAction)testButtonTouched:(id)sender {
    [self performSegueWithIdentifier:kSearchToProfileSegue sender:self];
}

@end
