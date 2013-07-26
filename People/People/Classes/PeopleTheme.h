//
//  PeopleTheme.h
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeopleTheme <NSObject>

+ (void)configureTheme;

+ (UIFont *)peopleFontBoldWithSize:(CGFloat)size;
+ (UIFont *)peopleFontBookWithSize:(CGFloat)size;
+ (UIFont *)peopleFontExtraBoldWithSize:(CGFloat)size;
+ (UIFont *)peopleFontExtraLightWithSize:(CGFloat)size;
+ (UIFont *)peopleFontLightWithSize:(CGFloat)size;
+ (UIFont *)peopleFontMediumWithSize:(CGFloat)size;
+ (UIFont *)peopleFontSemiBoldWithSize:(CGFloat)size;

+ (UIColor *)peopleColor1Primary;
+ (UIColor *)peopleColor1Secondary;
+ (UIColor *)peopleColor1Tertiary;

+ (UIColor *)peopleColor2Primary;
+ (UIColor *)peopleColor2Secondary;
+ (UIColor *)peopleColor2Tertiary;

+ (UIColor *)peopleColor3Primary;
+ (UIColor *)peopleColor3Secondary;
+ (UIColor *)peopleColor3Tertiary;

+ (UIColor *)peopleColor4Primary;
+ (UIColor *)peopleColor4Secondary;
+ (UIColor *)peopleColor4Tertiary;

+ (UIColor *)primaryButtonColorForState:(UIControlState)state;

@end
