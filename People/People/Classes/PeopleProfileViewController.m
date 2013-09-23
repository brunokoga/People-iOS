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
#import "PeopleHTTPClient.h"
#import "ProfileSMSEmailView.h"
#import "NSString+PhoneNumberFormatter.h"

//FIXME: remove this
#import "PeopleJSONParser.h"

@interface PeopleProfileViewController ()
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

@end

@implementation PeopleProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populate];
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


}

- (void)populateCoachView
{
    [[PeopleServices sharedServices] photoForUser:self.colaborador.managerLogin
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
        [[PeopleServices sharedServices] photoForUser:login
                                              success:^(UIImage *image) {
                                                  [self.teamView setImage:image forIndex:i];
                                              } failure:^(NSError *error) {
                                                  
                                              }];
    }
    
}

- (void)populatePhoneView
{
    [self.phoneNumbersView.phone1Button setPhoneNumber:self.colaborador.phone];
    [self.phoneNumbersView.phone2Button setPhoneNumber:self.colaborador.mobile];

}

- (void)populateNameView
{
    self.nameView.nameLabel.text = self.colaborador.name;
    self.nameView.roleLabel.text = self.colaborador.role;
    self.nameView.baseLabel.text = self.colaborador.location;
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
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];
    
    [httpClient profileForUser:colaborador.login
                       success:^(NSHTTPURLResponse *response, id responseObject) {

                           PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                           PeopleColaborador *colaboradorProfile = [jsonParser colaboradorFromProfileResponse:responseObject];
                           
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
    [[PeopleServices sharedServices] photoForUser:self.colaborador.login
                                          success:^(UIImage *image) {
                                              self.pictureView.image = image;
                                          } failure:^(NSError *error) {
                                              
                                          }];
    

}



@end
