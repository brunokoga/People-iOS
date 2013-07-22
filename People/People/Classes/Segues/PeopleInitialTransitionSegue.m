//
//  PeopleInitialTransitionSegue.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleInitialTransitionSegue.h"
#import "PeopleBaseViewController.h"

@implementation PeopleInitialTransitionSegue

- (void)perform
{
    PeopleBaseViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;

    [source performTransitionWithSegueIdentifier:self.identifier
                                      completion:^{
                                          [source.navigationController setViewControllers:@[destination]];
                                      }];
}
@end
