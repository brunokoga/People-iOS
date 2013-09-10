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

@interface PeopleProfileViewController ()
@property(nonatomic, strong, readwrite) IBOutlet UIView *containerView;
@property(nonatomic, strong, readwrite) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet ProfilePictureView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *topBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation PeopleProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
                         
//                         [self.pictureView setFrame:oldFrame];
                         
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
                        
                         
//                         [self.pictureView setFrame:frame];


                         [self.pictureView hideFavoritos:YES];
                     }];
    
}

- (void)setColaborador:(PeopleColaborador *)colaborador
{
    _colaborador = colaborador;
    [self downloadAndSetImage];
    //TODO: download image and set to pictureView
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
