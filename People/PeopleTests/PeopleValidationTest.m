//
//  PeopleValidationTest.m
//  People
//
//  Created by Bruno Koga on 7/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PeopleValidation.h"

@interface PeopleValidationTest : XCTestCase

@end

@implementation PeopleValidationTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testUsernameAndPasswordValidation
{
    PeopleValidation *validation = [[PeopleValidation alloc] init];
    NSString *username = nil;
    NSString *password = nil;
    BOOL valid = NO;
    NSError *error;
    
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Username and password invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;
    
    username = @"";
    password = nil;
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Username and password invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;

    username = nil;
    password = @"";
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Username and password invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;

    username = @"";
    password = @"";
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Username and password invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;
    
    username = @"valid_username";
    password = @"";
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Password invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;

    username = nil;
    password = @"valid_password";
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertFalse(valid, @"Username invalid");
    XCTAssertNotNil(error, @"Validation failed, therefore error must be not nil");
    error = nil;

    username = @"valid_username";
    password = @"valid_password";
    valid = [validation validUsername:username password:password error:&error];
    XCTAssertTrue(valid, @"Username and password are valid!");
    XCTAssertNil(error, @"Validation passed, therefore error must be nil");
    error = nil;
}
@end
