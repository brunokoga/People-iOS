//
//  PeopleValidation.h
//  People
//
//  Created by Bruno Koga on 7/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum NSInteger {
    PeopleValidationErrorBlankUsernameOnly          = 444,
    PeopleValidationErrorBlankPasswordOnly          = 445,
    PeopleValidationErrorBlankUsernameAndPassword   = 446
} PeopleValidationError;

@interface PeopleValidation : NSObject

- (BOOL)validUsername:(NSString *)username password:(NSString *)password error:(NSError **)error;

@end
