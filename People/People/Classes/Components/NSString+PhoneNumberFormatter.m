//
//  NSString+PhoneNumberFormatter.m
//  People
//
//  Created by Bruno Koga on 9/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "NSString+PhoneNumberFormatter.h"

@implementation NSString (PhoneNumberFormatter)

- (NSString *)phoneNumberFormat
{
    NSString *onlyNumbers = [[self componentsSeparatedByCharactersInSet:
                              [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                             componentsJoinedByString:@""];
    
    if ([self length] < 3)
    {
        onlyNumbers = @"";
    }
    
    if ([self length] == 4)
    {
        onlyNumbers = [@"192102" stringByAppendingString:onlyNumbers];
    }

    return onlyNumbers;
}


@end
