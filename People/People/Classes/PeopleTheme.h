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
+ (UIFont *)peopleFontThinWithSize:(CGFloat)size;
+ (UIFont *)peopleFontBlackWithSize:(CGFloat)size;
+ (UIFont *)peopleFontLightWithSize:(CGFloat)size;

+ (UIColor *)peopleColorPrimaryLight;
+ (UIColor *)peopleColorPrimaryNormal;
+ (UIColor *)peopleColorPrimaryDark;

+ (UIColor *)peopleColorSecondaryLight;
+ (UIColor *)peopleColorSecondaryDark;

+ (UIColor *)peopleColorBasicExtraLight;
+ (UIColor *)peopleColorBasicLight;
+ (UIColor *)peopleColorBasicNormal;
+ (UIColor *)peopleColorBasicDark;
+ (UIColor *)peopleColorBasicExtraDark;

+ (UIColor *)peopleColorTertiary;
@end
