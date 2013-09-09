//
//  PeopleInitialSetup.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleInitialSetup.h"
#import "PeoplePreferences.h"
#import "PeopleHTTPClient.h"

@implementation PeopleInitialSetup

+ (void)initialSetup
{
    [self configureHTTPCredentials];
}

+ (void)configureHTTPCredentials
{
    NSString *username = [PeoplePreferences username];
    NSString *password = [PeoplePreferences password];
    
    [[PeopleHTTPClient sharedClient] setUsername:username
                                        password:password];
}

@end
