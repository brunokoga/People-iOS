//
//  PeopleMessagesViewController.m
//  People
//
//  Created by Bruno Koga on 9/23/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleMessagesViewController.h"

@interface PeopleMessagesViewController ()

@end

@implementation PeopleMessagesViewController

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
    [self setup];
}

- (void)setup
{
    self.messageComposeDelegate = self;
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Message cancelled");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed");
            break;
        case MessageComposeResultSent:
            NSLog(@"Message sent");
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
