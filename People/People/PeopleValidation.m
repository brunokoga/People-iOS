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
        PeopleValidationError errorCode;
        if (usernameError)
        {
            if (passwordError)
            {
                errorCode = PeopleValidationErrorBlankUsernameAndPassword;
            }
            else
            {
                errorCode = PeopleValidationErrorBlankUsernameOnly;
            }
        }
        else
        {
            errorCode = PeopleValidationErrorBlankPasswordOnly;
        }
        
        *error = [NSError errorWithDomain:@"com.ciandt.people.validationError"
                                     code:errorCode
                                 userInfo:nil];
    }
    
    return valid;
}

@end
