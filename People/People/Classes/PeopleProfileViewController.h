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


@end
