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
    [self configureNavigationBar];
}

+ (void)configureNavigationBar
{
    UIImage *backgroundImage = [UIImage imageNamed:@"DefaultBackground"];
    [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *navigationBarTitleAttributes = [NSMutableDictionary dictionary];
    [navigationBarTitleAttributes setValue:[self peopleFontMediumWithSize:24.0] forKey:NSFontAttributeName];
    [navigationBarTitleAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:navigationBarTitleAttributes];
    
    CGRect newFrame = CGRectMake(0, 0, 320, 80);
    [[UINavigationBar appearance]  setFrame:newFrame];
    
    //removing the navigation's bar shadow
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"btn-backblue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
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


//1 = Blue
//2 = Gray
//3 = Red
//4 = Yellow
+ (UIColor *)peopleColor1Primary
{
    return [UIColor colorWithRed:53.0/255.0 green:136.0/255.0 blue:220.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor1Secondary
{
    return [UIColor colorWithRed:115.0/255.0 green:177.0/255.0 blue:239.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor1Tertiary
{
    return nil;
}

+ (UIColor *)peopleColor2Primary
{
    return [UIColor colorWithRed:91.0/255.0 green:98.0/255.0 blue:107.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor2Secondary
{
    return [UIColor colorWithRed:151.0/255.0 green:159.0/255.0 blue:167.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor2Tertiary
{
    return [UIColor colorWithRed:217.0/255.0 green:220.0/255.0 blue:223.0/255.0 alpha:1.0];}

+ (UIColor *)peopleColor3Primary
{
    return [UIColor colorWithRed:255.0/255.0 green:78.0/255.0 blue:99.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor3Secondary
{
    return [UIColor colorWithRed:163.0/255.0 green:63.0/255.0 blue:75.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor3Tertiary
{
    return nil;
}


+ (UIColor *)peopleColor4Primary
{
    return [UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:120.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor4Secondary
{
    return [UIColor colorWithRed:231.0/255.0 green:194.0/255.0 blue:82.0/255.0 alpha:1.0];
}

+ (UIColor *)peopleColor4Tertiary
{
    return nil;
}



+ (UIColor *)primaryButtonColorForState:(UIControlState)state
{
    UIColor *returnColor;
    switch (state) {
        case UIControlStateNormal:
            returnColor = [UIColor whiteColor];
            break;
        case UIControlStateHighlighted:
            returnColor = [UIColor grayColor];
            break;
            
        default:
            break;
    }
    return returnColor;
}



@end
