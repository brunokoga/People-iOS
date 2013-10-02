//
//  PeopleContactServices.m
//  People
//
//  Created by Christian Sampaio on 10/2/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleContactServices.h"
#import "PeopleMailViewController.h"
#import "PeopleModalTransitionDelegate.h"
#import "PeopleMessagesViewController.h"

@interface PeopleContactServices () <UIAlertViewDelegate>

@property (nonatomic, strong) PeopleModalTransitionDelegate *modalTransitionDelegate;

@end

@implementation PeopleContactServices

+ (instancetype)sharedServices
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    
    return _singleton;
}


- (void)presentEmailComposerOnViewController:(UIViewController *)controller
                              withRecipients:(NSArray *)recipients
{
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *emailTitle = @"";
        // Email Content
        NSString *messageBody = NSLocalizedString(@"Sent from People for iOS",@"Footer message on email body");
        // To address
        
        PeopleMailViewController *mailViewController = [[PeopleMailViewController alloc] init];
        [mailViewController setSubject:emailTitle];
        [mailViewController setMessageBody:messageBody isHTML:NO];
        [mailViewController setToRecipients:recipients];
        
        
        // Present mail view controller on screen
        
        mailViewController.transitioningDelegate = self.modalTransitionDelegate;
        mailViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        [controller presentViewController:mailViewController
                                 animated:YES
                               completion:NULL];
        
    }
    else
    {
        //TODO: show error message that cannot send email;
    }
}

- (void)presentSMSComposerOnViewController:(UIViewController *)controller
                            withRecipients:(NSArray *)recipients
{
    if ([MFMessageComposeViewController canSendText])
    {
        // Email Content
        NSString *messageBody = @"";
        
        PeopleMessagesViewController *messagesViewController = [[PeopleMessagesViewController alloc] init];
        [messagesViewController setRecipients:recipients];
        [messagesViewController setBody:messageBody];
        
        messagesViewController.transitioningDelegate = self.modalTransitionDelegate;
        messagesViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        [controller presentViewController:messagesViewController
                                 animated:YES
                               completion:NULL];
    }
    else
    {
        //TODO: show error message that cannot send email;
    }
}

- (void)callPhoneNumber:(NSNumber *)phoneNumber
{
    NSString *telString = [@"tel://" stringByAppendingString:[phoneNumber stringValue]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telString]])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[phoneNumber stringValue]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"Call", @""), nil];
        [alertView show];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //Cancel
            break;
        case 1: //Call
        {
            NSString *number = [NSString stringWithFormat:@"%d", alertView.tag];
            NSString *telString = [@"tel://" stringByAppendingString:number];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
            break;
        }
        default:
            break;
    }
}

#pragma mark Getters/Setters

- (PeopleModalTransitionDelegate *)modalTransitionDelegate
{
    if (!_modalTransitionDelegate)
    {
        _modalTransitionDelegate = [[PeopleModalTransitionDelegate alloc] init];
    }
    return _modalTransitionDelegate;
}

@end
