//
//  PeopleValidation.m
//  People
//
//  Created by Bruno Koga on 7/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleValidation.h"

@implementation PeopleValidation

- (BOOL)validUsername:(NSString *)username password:(NSString *)password error:(NSError **)error;
{
    BOOL usernameError = ([username length] == 0);
    BOOL passwordError = ([password length] == 0);
    
    BOOL valid = (!usernameError && !passwordError);
    
    if (!valid)
    {
        *error = [[NSError alloc] init];
    }
    
    return valid;
}

@end
