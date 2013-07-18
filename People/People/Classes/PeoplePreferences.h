//
//  PeoplePreferences.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeoplePreferences : NSObject

+ (BOOL)isAutoLoginOn;
+ (void)setAutoLogin:(BOOL)onOff;

+ (BOOL)isRunningForTheFirstTime;
+ (void)setRunningForTheFirstTime:(BOOL)yesNo;

+ (NSString *)username;
+ (NSString *)password;
+ (void)setUsername:(NSString *)username
           password:(NSString *)password;
+ (void)resetUsernameAndPassword;

@end
