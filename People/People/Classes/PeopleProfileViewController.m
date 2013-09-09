//
//  PeopleProfileViewController.m
//  People
//
//  Created by Bruno Koga on 7/25/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileViewController.h"

@interface PeopleProfileViewController ()
@property(nonatomic, strong, readwrite) IBOutlet UIView *containerView;
@property(nonatomic, strong, readwrite) IBOutlet UIView *contentView;


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


@end
