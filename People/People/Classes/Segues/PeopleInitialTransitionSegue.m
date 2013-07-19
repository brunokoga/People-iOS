//
//  PeopleInitialTransitionSegue.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleInitialTransitionSegue.h"
#import "PeopleInitialViewController.h"

@implementation PeopleInitialTransitionSegue

- (void)perform
{
    PeopleInitialViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    [source performInitialAnimationWithCompletion:^{
        [source.navigationController setViewControllers:@[destination]];
    }];
}
@end
