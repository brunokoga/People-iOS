//
//  PeopleBasicTheme.m
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBasicTheme.h"

@implementation PeopleBasicTheme

NSString * const kPeopleFontName = @"Dosis-Bold";
NSString * const kPeopleFontBookName = @"Dosis-Book";
NSString * const kPeopleFontExtraBoldName = @"Dosis-ExtraBold";
NSString * const kPeopleFontExtraLightName = @"Dosis-ExtraLight";
NSString * const kPeopleFontLightName = @"Dosis-Light";
NSString * const kPeopleFontMediumName = @"Dosis-Medium";
NSString * const kPeopleFontSemiBoldName = @"Dosis-SemiBold";

+ (void)configureTheme
{

}

+ (UIFont *)peopleFontBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontName size:size];
}

+ (UIFont *)peopleFontBookWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontBookName size:size];
}

+ (UIFont *)peopleFontExtraBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontExtraBoldName size:size];
}

+ (UIFont *)peopleFontExtraLightWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontExtraLightName size:size];
}

+ (UIFont *)peopleFontLightWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontLightName size:size];
}

+ (UIFont *)peopleFontMediumWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontMediumName size:size];
}

+ (UIFont *)peopleFontSemiBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleFontSemiBoldName size:size];
}

+ (UIColor *)peopleColorPrimaryLight
{
    return [UIColor colorWithRed:44.0/255.0 green:128.0/255.0 blue:213.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorPrimaryNormal
{
    return [UIColor colorWithRed:25.0/255.0 green:92.0/255.0 blue:159.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorPrimaryDark
{
    return [UIColor colorWithRed:19.0/255.0 green:80.0/255.0 blue:138.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorSecondaryLight
{
    return [UIColor colorWithRed:255.0/255.0 green:30.0/255.0 blue:100.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorSecondaryDark
{
    return [UIColor colorWithRed:147.0/255.0 green:11.0/255.0 blue:65.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorBasicExtraLight
{
    return [UIColor colorWithRed:205.0/255.0 green:210.0/255.0 blue:220.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorBasicLight
{
    return [UIColor colorWithRed:155.0/255.0 green:163.0/255.0 blue:180.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorBasicNormal
{
    return [UIColor colorWithRed:80.0/255.0 green:84.0/255.0 blue:99.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorBasicDark
{
    return [UIColor colorWithRed:34.0/255.0 green:39.0/255.0 blue:46.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorBasicExtraDark
{
    return [UIColor colorWithRed:28.0/255.0 green:33.0/255.0 blue:43.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColorTertiary
{
    return [UIColor colorWithRed:241.0/255.0 green:210.0/255.0 blue:0.0/255.0 alpha:1.0];
}


@end
