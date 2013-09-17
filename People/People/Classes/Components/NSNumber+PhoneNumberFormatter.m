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
    
        NSSet *brPrefixes = [NSSet setWithObjects:
                             @"11",
                             @"19",
                             @"21",
                             @"31",
                             nil];
        
        NSString *prefix = [selfString substringToIndex:2];
        NSString *number;
        NSString *firstNumbers;
        NSString *lastNumbers;

        if ([brPrefixes containsObject:prefix])
        {
            number = [selfString substringFromIndex:2];
            firstNumbers = [number substringToIndex:4];
            lastNumbers = [number substringFromIndex:4];
            
            selfString = [[NSString alloc] initWithFormat:@"%@ %@ %@", prefix, firstNumbers, lastNumbers];
            returnValue = selfString;
        } else {
            prefix = [selfString substringToIndex:3];
            number = [selfString substringFromIndex:3];
            firstNumbers = [number substringToIndex:3];
            lastNumbers = [number substringFromIndex:3];
            
            selfString = [[NSString alloc] initWithFormat:@"%@ %@ %@", prefix, firstNumbers, lastNumbers];
            returnValue = selfString;
        }
    }
    
    return returnValue;
}

@end
