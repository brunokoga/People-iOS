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
    [self.phoneNumbersView.phone1Button setPhoneNumber:self.colaborador.phone];
    [self.phoneNumbersView.phone2Button setPhoneNumber:self.colaborador.mobile];
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
{
    CGRect oldFrame = self.pictureView.frame;
    [self.pictureView setFrame:frame];
    self.topBackgroundImageView.alpha = 0.0f;
    self.moreButton.alpha = 0.0f;
    [self.pictureView hideFavoritos:YES];
    [UIView animateWithDuration:duration
                     animations:^{
                         self.topBackgroundImageView.alpha = 1.0f;
                         self.moreButton.alpha = 1.0f;
                         
                         [self.pictureView animateCornerRadiusFromFrame:frame
                                                                toFrame:oldFrame
                                                               duration:duration];
                        
                         [self.pictureView hideFavoritos:NO];
                     }];
    
}

- (void)performProfileToListAnimationWithDuration:(NSTimeInterval)duration
                                     pictureFrame:(CGRect)frame
{
    [UIView animateWithDuration:duration
                     animations:^{
                         self.topBackgroundImageView.alpha = 0.0f;
                         self.moreButton.alpha = 0.0f;
                         
                         [self.pictureView animateCornerRadiusFromFrame:self.pictureView.frame
                                                                toFrame:frame
                                                               duration:duration];
                        
                         [self.pictureView hideFavoritos:YES];
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

                                          } failure:^(NSError *error) {
                                              
                                          }];
    

}



@end
