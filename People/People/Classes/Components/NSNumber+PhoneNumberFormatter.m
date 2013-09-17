//
//  NSNumber+PhoneNumberFormatter.m
//  People
//
//  Created by Bruno Koga on 9/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "NSNumber+PhoneNumberFormatter.h"

@implementation NSNumber (PhoneNumberFormatter)

/*
 Ótimo lugar para se fazer Unit Tests...
 */

- (NSString *)formattedPhoneNumberString
{
    NSString *returnValue = @"";
    NSString *selfString = [self stringValue];

    if ([selfString length] == 10) {
    
        NSString *prefix = [selfString substringToIndex:2];
        NSString *number = [selfString substringFromIndex:2];
        NSString *firstNumbers = [number substringToIndex:4];
        NSString *lastNumbers = [number substringFromIndex:4];
        
        selfString = [[NSString alloc] initWithFormat:@"%@ %@ %@", prefix, firstNumbers, lastNumbers];
        returnValue = selfString;
    }
    
    return returnValue;
}

@end
