//
//  PeoplePreferences.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeoplePreferences.h"
#import <SSKeychain/SSKeychain.h>

@implementation PeoplePreferences

#pragma mark - Private Methods
#pragma mark - NSUserDefaults Wrapper

+ (BOOL)boolForKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults boolForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setBool:value forKey:key];
    [standardUserDefaults synchronize];
}

#pragma mark - Public Methods
#pragma mark - Auto Login

static NSString * const kAutoLoginKey = @"kAutoLoginKey";

+ (BOOL)isAutoLoginOn
{
    return [self boolForKey:kAutoLoginKey];
}

+ (void)setAutoLogin:(BOOL)onOff
{
    [self setBool:onOff forKey:kAutoLoginKey];
}

#pragma mark - Running For The First Time

static NSString * const kAppDidRunBefore = @"kAppDidRunBefore";

+ (BOOL)isRunningForTheFirstTime
{
    BOOL isRunningForTheFirstTime = ![self boolForKey:kAppDidRunBefore];
    return isRunningForTheFirstTime;
}

+ (void)setRunningForTheFirstTime:(BOOL)yesNo
{
    BOOL appDidRunBefore = !yesNo;
    [self setBool:appDidRunBefore forKey:kAppDidRunBefore];
}

#pragma mark - Username and Password

static NSString * const kPeopleServiceKeychain = @"People";
static NSString * const kUsernameKeychainKey = @"PeopleUsernameKeychainKey";

+ (NSString *)username
{
    return [SSKeychain passwordForService:kPeopleServiceKeychain account:kUsernameKeychainKey];
}

+ (void)setUsername:(NSString *)username
{
    [SSKeychain setPassword:username
                 forService:kPeopleServiceKeychain
                    account:kUsernameKeychainKey];
}

static NSString * const kPasswordKeychainKey = @"PeoplePasswordKeychainKey";

+ (NSString *)password
{
    return [SSKeychain passwordForService:kPeopleServiceKeychain account:kPasswordKeychainKey];
}

+ (void)setPassword:(NSString *)password
{
    [SSKeychain setPassword:password
                 forService:kPeopleServiceKeychain
                    account:kPasswordKeychainKey];
}

+ (void)setUsername:(NSString *)username
           password:(NSString *)password
{
    [self setUsername:username];
    [self setPassword:password];
}

+ (void)resetUsernameAndPassword
{
    [SSKeychain deletePasswordForService:kPeopleServiceKeychain account:kUsernameKeychainKey];
    [SSKeychain deletePasswordForService:kPeopleServiceKeychain account:kPasswordKeychainKey];
}

@end
