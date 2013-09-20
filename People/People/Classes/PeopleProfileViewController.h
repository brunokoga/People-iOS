//
//  PeopleProfileViewController.h
//  People
//
//  Created by Bruno Koga on 7/25/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBaseViewController.h"
#import "PeopleColaborador.h"

@interface PeopleProfileViewController : PeopleBaseViewController

@property (nonatomic, retain) PeopleColaborador *colaborador;
@property(nonatomic, strong, readonly) UIView *containerView;
@property(nonatomic, strong, readonly) UIView *contentView;

- (CGRect)frameForContainerView;
- (void)performListToProfileAnimationWithDuration:(NSTimeInterval)duration
                                     pictureFrame:(CGRect)frame
                                      phone1Frame:(CGRect)phone1Frame
                                      phone2Frame:(CGRect)phone2Frame
                                        nameFrame:(CGRect)nameFrame
                                        roleFrame:(CGRect)roleFrame;

- (void)performProfileToListAnimationWithDuration:(NSTimeInterval)duration
                                     pictureFrame:(CGRect)frame
                                      phone1Frame:(CGRect)phone1Frame
                                      phone2Frame:(CGRect)phone2Frame
                                        nameFrame:(CGRect)nameFrame
                                        roleFrame:(CGRect)roleFrame;


@end
