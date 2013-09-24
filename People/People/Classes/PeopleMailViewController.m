//
//  PeopleMailViewController.m
//  People
//
//  Created by Bruno Koga on 9/23/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleMailViewController.h"
#import "PeopleBasicTheme.h"

@interface PeopleMailViewController ()

@end

@implementation PeopleMailViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setup
{
    self.mailComposeDelegate = self;
    [self configureNavigationBar];
}

- (void)configureNavigationBar
{
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *navigationBarTitleAttributes = [NSMutableDictionary dictionary];
    [navigationBarTitleAttributes setValue:[PeopleBasicTheme peopleFontMediumWithSize:24.0] forKey:NSFontAttributeName];
    [navigationBarTitleAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationBar setTitleTextAttributes:navigationBarTitleAttributes];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
