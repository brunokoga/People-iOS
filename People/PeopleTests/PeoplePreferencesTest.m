//
//  PeoplePreferences.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PeoplePreferences.h"
#import "PeoplePreferences_Private.h"

@interface PeoplePreferencesTest : XCTestCase

@end

@implementation PeoplePreferencesTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [PeoplePreferences resetUsernameAndPassword];
    [super tearDown];
}

- (void)testNSUserDefaultsWrapper
{
    NSString *newKey = @"This is a new and unused Key";
    BOOL boolForNewKey = [PeoplePreferences boolForKey:newKey];
    XCTAssertFalse(boolForNewKey, @"A standard value for a new key should be NO");

    [PeoplePreferences setBool:YES forKey:newKey];
    boolForNewKey = [PeoplePreferences boolForKey:newKey];
    XCTAssert(boolForNewKey, @"We're expecting a YES...");

    newKey = @"This is another new and unused Key";
    boolForNewKey = [PeoplePreferences boolForKey:newKey];
    XCTAssertFalse(boolForNewKey, @"A standard value for a new key should be NO");

    [PeoplePreferences setBool:YES forKey:newKey];
    boolForNewKey = [PeoplePreferences boolForKey:newKey];
    XCTAssert(boolForNewKey, @"We're expecting a YES...");
}

- (void)testAutoLogin
{
    BOOL autoLogin = [PeoplePreferences isAutoLoginOn];
    XCTAssertFalse(autoLogin, @"Auto Login should be False on first run");
    
    [PeoplePreferences setAutoLogin:YES];
    autoLogin = [PeoplePreferences isAutoLoginOn];
    XCTAssert(autoLogin, @"Auto Login should be True here");
    
    [PeoplePreferences setAutoLogin:NO];
    autoLogin = [PeoplePreferences isAutoLoginOn];
    XCTAssertFalse(autoLogin, @"Auto Login should be False here");
}

- (void)testRunningForTheFirstTime
{
    BOOL runningForTheFirstTime = [PeoplePreferences isRunningForTheFirstTime];
    XCTAssert(runningForTheFirstTime, @"Running For The First Time should be True on first run");

    [PeoplePreferences setAutoLogin:NO];
    runningForTheFirstTime = [PeoplePreferences isAutoLoginOn];
    XCTAssertFalse(runningForTheFirstTime, @"Running For The First Time should be False here");

    [PeoplePreferences setRunningForTheFirstTime:YES];
    runningForTheFirstTime = [PeoplePreferences isRunningForTheFirstTime];
    XCTAssert(runningForTheFirstTime, @"Running For The First Time should be True here");
}

- (void)testUsernameAndPassword
{
    NSString *username = [PeoplePreferences username];
    NSString *password = [PeoplePreferences password];
    XCTAssertNil(username, @"Username is expected to be nil at first run");
    XCTAssertNil(password, @"Password is expected to be nil at first run");
    
    NSString *newUsername = @"Bruno Koga";
    [PeoplePreferences setUsername:newUsername password:password];
    username = [PeoplePreferences username];
    password = [PeoplePreferences password];
    XCTAssertEqualObjects(username, newUsername, @"Usernames expected to be equal");
    XCTAssertNil(password, @"Password is expected to be nil since it was not set");
    
    newUsername = @"Marília Boer";
    NSString *newPassword = @"AbC123#$%?'*`";
    [PeoplePreferences setUsername:newUsername password:newPassword];
    username = [PeoplePreferences username];
    password = [PeoplePreferences password];
    XCTAssertEqualObjects(username, newUsername, @"Usernames expected to be equal");
    XCTAssertEqualObjects(password, newPassword, @"Passwords expected to be equal");
    
    [PeoplePreferences resetUsernameAndPassword];
    username = [PeoplePreferences username];
    password = [PeoplePreferences password];
    XCTAssertNil(username, @"Username is expected to be nil after reset");
    XCTAssertNil(password, @"Password is expected to be nil after reset");
}


@end
