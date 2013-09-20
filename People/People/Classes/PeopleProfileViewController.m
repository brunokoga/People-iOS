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

    CGPoint nameOldCenter = CGPointMake(160, 32);
    CGPoint roleOldCenter = CGPointMake(160, 62);

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
                         
                     } completion:^(BOOL finished) {
                     }];
    


    
}

- (void)setColaborador:(PeopleColaborador *)colaborador
{
    _colaborador = colaborador;
}

- (void)downloadAndSetImage
{
    [[PeopleServices sharedServices] photoForUser:self.colaborador.login
                                          success:^(UIImage *image) {
                                              self.pictureView.image = image;
                                              [self.teamView setTeamMemberNames:@[@"a", @"b", @"c"]];
                                              [self.phoneNumbersView.phone1Button setPhoneNumber:self.colaborador.phone];
                                              [self.phoneNumbersView.phone2Button setPhoneNumber:self.colaborador.mobile];
                                              self.nameView.nameLabel.text = self.colaborador.name;
                                              self.nameView.roleLabel.text = self.colaborador.role;
                                              self.nameView.baseLabel.text = self.colaborador.location;
                                          } failure:^(NSError *error) {
                                              
                                          }];
    

}



@end
