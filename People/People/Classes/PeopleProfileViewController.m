//
//  PeopleProfileViewController.m
//  People
//
//  Created by Bruno Koga on 7/25/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileViewController.h"
#import "ProfilePictureView.h"
#import "PeopleServices.h"
#import "ProfileNameView.h"
#import "ProfilePhoneNumbersView.h"
#import "ProfileCoachView.h"
#import "ProfileTeamView.h"
#import "ProfileProjectsView.h"
#import "ProfileSMSEmailView.h"
#import "NSString+PhoneNumberFormatter.h"
#import "PeopleMailViewController.h"
#import "PeopleMessagesViewController.h"
#import "NSString+PhoneNumberFormatter.h"
#import "PeopleModalTransitionDelegate.h"

@interface PeopleProfileViewController () <UIAlertViewDelegate>
@property(nonatomic, strong, readwrite) IBOutlet UIView *containerView;
@property(nonatomic, strong, readwrite) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet ProfilePictureView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *topBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet ProfileNameView *nameView;
@property (weak, nonatomic) IBOutlet ProfilePhoneNumbersView *phoneNumbersView;
@property (weak, nonatomic) IBOutlet ProfileCoachView *coachView;
@property (weak, nonatomic) IBOutlet ProfileTeamView *teamView;
@property (weak, nonatomic) IBOutlet ProfileProjectsView *projectsView;
@property (weak, nonatomic) IBOutlet ProfileSMSEmailView *smsEmailView;
@property (strong, nonatomic) PeopleModalTransitionDelegate *modalTransitionDelegate;

@end

@implementation PeopleProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.projectsView setHidden:YES];
    [self populate];
    self.modalTransitionDelegate = [[PeopleModalTransitionDelegate alloc] init];
	// Do any additional setup after loading the view.
}

- (void)populate
{
    [self downloadAndSetImage];
    [self populatePhoneView];
    [self populateNameView];
    [self populateCoachView];
    [self populateSmsEmailView];
    [self.scrollView setContentSize:CGSizeMake(320.0, 900.0)];
}

- (void)populateSmsEmailView
{
    NSAttributedString *emailAttributedString = [self.colaborador.login ciandtEmailWithFocusOnLogin];
    [self.smsEmailView setEmailAttributedString:emailAttributedString];
    [self.smsEmailView setEmailTarget:self
                               action:@selector(presentMailViewControllerToEmail)];
    
    [self.smsEmailView setSMSTarget:self
                               action:@selector(presentMessagesViewControllerToNumber)];
}
/*
 This is called after the colaborador profile is reached
 */
- (void)populateProjectsView
{

    [self.projectsView setPastProjects:self.colaborador.pastProjectsNames
                       currentProjects:self.colaborador.currentProjectsNames];
    
    CGFloat offset = 400.0;
    if (self.view.window.frame.size.height == 568.0) offset = 300.0;
    [self.scrollView setContentSize:CGSizeMake(320.0, [self.projectsView totalHeight] + offset)];
        [self.projectsView setHidden:NO];

}

- (void)populateCoachView
{
    [PeopleServices photoForUser:self.colaborador.managerLogin
                         success:^(UIImage *image) {
                             [self.coachView setCoachPicture:image];
                         } failure:^(NSError *error) {
                             
                         }];
    
    [self.coachView setCoachName:self.colaborador.managerLogin];

    
}

//should be called only after the profile is returned from the server
- (void)populateTeamView
{
    
    NSArray *teamMembers = [[self.colaborador.teammates valueForKeyPath:@"login"] allObjects];
    [self.teamView setTeamMemberNames:teamMembers];
    
    for (int i = 0; i < [teamMembers count]; i++)
    {
        NSString *login = teamMembers[i];
        [PeopleServices photoForUser:login
                             success:^(UIImage *image) {
                                 [self.teamView setImage:image forIndex:i];
                             } failure:^(NSError *error) {
                                 
                             }];
    }
    
}

- (void)teamButtonTouched:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *login = [self.teamView teamMemberNames][button.tag];

    [self openProfileForColaboradorWithLogin:login];
    

}

- (void)openProfileForColaboradorWithLogin:(NSString *)login
{
    [[PeopleServices sharedServices] colaboradoresForSearchTerm:login
                                                         success:^(NSArray *colaboradores) {
                                                             PeopleColaborador *colaborador = colaboradores[0];
                                                             
                                                             
                                                             
                                                             PeopleProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeopleProfileViewController"];
                                                             [profileViewController setColaborador:colaborador];
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [self.navigationController pushViewController:profileViewController animated:YES];

                                                             });
                                                             
                                                         } failure:^(NSError *error) {
                                                             //handle error
                                                         }];

    
}

- (void)populatePhoneView
{
    [self.phoneNumbersView.phone1Button setPhoneNumber:self.colaborador.phone];
    [self.phoneNumbersView.phone2Button setPhoneNumber:self.colaborador.mobile];
    
    [self.phoneNumbersView.phone1Button addTarget:self
                                           action:@selector(phone1ButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

    [self.phoneNumbersView.phone2Button addTarget:self
                                           action:@selector(phone2ButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)populateNameView
{
    self.nameView.nameLabel.text = self.colaborador.name;
    self.nameView.roleLabel.text = self.colaborador.role;
    self.nameView.baseLabel.text = self.colaborador.location;
    self.nameView.buildingLabel.text = self.colaborador.building;
}



- (void)adjustLocalizationItems
{
    //overriden
}

- (void)adjustFonts
{
    //overriden
}

- (void)adjustColors
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (CGRect)frameForContainerView {
    return self.view.bounds;
}

#pragma mark - Transitions & Animations

- (void)performListToProfileAnimationWithDuration:(NSTimeInterval)duration
                                     pictureFrame:(CGRect)frame
                                      phone1Frame:(CGRect)phone1Frame
                                      phone2Frame:(CGRect)phone2Frame
                                        nameFrame:(CGRect)nameFrame
                                        roleFrame:(CGRect)roleFrame
{
    CGRect oldFrame = self.pictureView.frame;
    [self.pictureView setFrame:frame];
    self.topBackgroundImageView.alpha = 0.0f;
    self.moreButton.alpha = 0.0f;
    [self.pictureView hideFavoritos:YES];
    
    //todo: change that
    CGRect phone1OldFrame = CGRectMake(0, 0, 160, 50);
    CGRect  phone2OldFrame = CGRectMake(160, 0, 160, 50);
    self.phoneNumbersView.phone1Button.frame = phone1Frame;
    self.phoneNumbersView.phone2Button.frame = phone2Frame;

    CGPoint nameOldCenter = self.nameView.nameLabel.center;
    CGPoint roleOldCenter = self.nameView.roleLabel.center;

    self.nameView.nameLabel.frame = nameFrame;
    self.nameView.roleLabel.frame = roleFrame;

    self.nameView.alpha = 0.0f;

    [UIView animateWithDuration:duration
                     animations:^{
                         self.topBackgroundImageView.alpha = 1.0f;
                         self.moreButton.alpha = 1.0f;
                         
                         [self.pictureView animateCornerRadiusFromFrame:frame
                                                                toFrame:oldFrame
                                                               duration:duration];
                         
                         self.phoneNumbersView.phone1Button.frame = phone1OldFrame;
                         self.phoneNumbersView.phone2Button.frame = phone2OldFrame;
                         self.nameView.nameLabel.center = nameOldCenter;
                         self.nameView.roleLabel.center = roleOldCenter;
                         [self.pictureView hideFavoritos:NO];
                         self.nameView.alpha = 1.0f;
                     }];
    
}

- (void)performProfileToListAnimationWithDuration:(NSTimeInterval)duration
                                     pictureFrame:(CGRect)frame
                                      phone1Frame:(CGRect)phone1Frame
                                      phone2Frame:(CGRect)phone2Frame
                                        nameFrame:(CGRect)nameFrame
                                        roleFrame:(CGRect)roleFrame
{

    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.topBackgroundImageView.alpha = 0.0f;
                         self.moreButton.alpha = 0.0f;
                         self.phoneNumbersView.alpha = 0;
                         self.nameView.alpha = 0;
//                         self.nameView.nameLabel.transform = CGAffineTransformMakeScale(0.5,0.8);
                         
                         [self.pictureView animateCornerRadiusFromFrame:self.pictureView.frame
                                                                toFrame:frame
                                                               duration:duration];
                         
                         [self.pictureView hideFavoritos:YES];
                     }];
    
    [UIView animateWithDuration:2*duration/3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.phoneNumbersView.phone1Button.frame = phone1Frame;
                         self.phoneNumbersView.phone2Button.frame = phone2Frame;
                         self.nameView.nameLabel.frame = nameFrame;
                         self.nameView.roleLabel.frame = roleFrame;
                                                  self.teamView.alpha = 0;
                     } completion:^(BOOL finished) {
                     }];
    


    
}

- (void)setColaborador:(PeopleColaborador *)colaborador
{
    _colaborador = colaborador;
    self.title = colaborador.login;
    
    [PeopleServices profileForUser:colaborador.login
                           success:^(PeopleColaborador *colaboradorProfile) {
                               self.colaborador.teammates = colaboradorProfile.teammates;
                               self.colaborador.currentProjects = colaboradorProfile.currentProjects;
                               self.colaborador.pastProjects = colaboradorProfile.pastProjects;
                               [self populateTeamView];
                               [self populateProjectsView];
                           } failure:^(NSError *error) {
                               
                           }];
    
}

- (void)downloadAndSetImage
{
    [PeopleServices photoForUser:self.colaborador.login
                         success:^(UIImage *image) {
                             self.pictureView.image = image;
                         } failure:^(NSError *error) {
                             
                         }];
}

- (void)presentMessagesViewControllerToNumber
{
    [self presentMessagesViewControllerToNumber:self.colaborador.phone];
}

- (void)presentMessagesViewControllerToNumber:(NSNumber *)number
{
    if ([MFMessageComposeViewController canSendText])
    {
        // Email Content
        NSString *messageBody = @"";
        // To address
        NSString *numberString = [number stringValue];
        NSArray *toRecipents = @[numberString];
        
        
        PeopleMessagesViewController *messagesViewController = [[PeopleMessagesViewController alloc] init];
        [messagesViewController setRecipients:toRecipents];
        [messagesViewController setBody:messageBody];
        
        messagesViewController.transitioningDelegate = self.modalTransitionDelegate;
        messagesViewController.modalPresentationStyle = UIModalPresentationCustom;

        [self presentViewController:messagesViewController
                           animated:YES
                         completion:NULL];
    } else
    {
        //TODO: show error message that cannot send email;        
    }
}

- (void)presentMailViewControllerToEmail
{
    [self presentMailViewControllerToEmail:[self.colaborador.login ciandtEmail]];
}

- (void)presentMailViewControllerToEmail:(NSString *)email
{
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *emailTitle = @"";
        // Email Content
        NSString *messageBody = NSLocalizedString(@"Sent from People for iOS",@"Footer message on email body");
        // To address
        NSArray *toRecipents = @[email];
        
        PeopleMailViewController *mailViewController = [[PeopleMailViewController alloc] init];
        [mailViewController setSubject:emailTitle];
        [mailViewController setMessageBody:messageBody isHTML:NO];
        [mailViewController setToRecipients:toRecipents];
        

        // Present mail view controller on screen
        
        mailViewController.transitioningDelegate = self.modalTransitionDelegate;
        mailViewController.modalPresentationStyle = UIModalPresentationCustom;

        [self presentViewController:mailViewController
                           animated:YES
                         completion:NULL];
        
    } else {
        //TODO: show error message that cannot send email;
    }

}

- (void)phone1ButtonTouched:(id)sender
{
    [self displayAlertViewToCallNumber:[self.colaborador.phone stringValue]];
}

- (void)phone2ButtonTouched:(id)sender
{
    [self displayAlertViewToCallNumber:[self.colaborador.mobile stringValue]];
}

- (void)displayAlertViewToCallNumber:(NSString *)number
{
    NSString *telString = [@"tel://" stringByAppendingString:number];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telString]])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:number
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"Call", @""), nil];
        alertView.tag = [number integerValue];
        [alertView show];
    }
}

#pragma mark - UIAlertView Delegate

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

@end
