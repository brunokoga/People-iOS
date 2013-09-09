//
//  PeopleNavigationController.m
//  People
//
//  Created by Bruno Koga on 7/31/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleNavigationController.h"
#import "PeopleNavigationControllerDelegate.h"

@interface PeopleNavigationController ()

@property (nonatomic, strong) id<UINavigationControllerDelegate> transitionDelegate;
@end

@implementation PeopleNavigationController

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
    self.transitionDelegate = [PeopleNavigationControllerDelegate new];
    self.delegate = self.transitionDelegate;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
