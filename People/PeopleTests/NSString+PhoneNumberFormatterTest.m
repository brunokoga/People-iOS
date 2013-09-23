//
//  NSString+PhoneNumberFormatterTest.m
//  People
//
//  Created by Bruno Koga on 9/23/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+PhoneNumberFormatter.h"

@interface NSString_PhoneNumberFormatterTest : XCTestCase

@end

@implementation NSString_PhoneNumberFormatterTest

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

- (void)testPhoneNumberFormat
{
    NSString *phone = @"4500";
    NSString *formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"1921024500", @"Wrong!");
    
    phone = @"0000";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"1921020000", @"Wrong!");
    
    phone = @"0001";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"1921020001", @"Wrong!");
    
    phone = @"9999";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"1921029999", @"Wrong!");
    
    phone = @"";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"", @"Wrong!");
    
    phone = @"1";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"", @"Wrong!");
    
    phone = @"999";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"", @"Wrong!");

    phone = @"99999";
    formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"99999", @"Wrong!");
    
}

- (void)testCiandtEmailWithFocusOnLogin
{
    NSString *login = @"mylogin";
    NSAttributedString *email = [login ciandtEmailWithFocusOnLogin];
    NSString *emailString = [email string];
    
    XCTAssertEqualObjects([emailString substringToIndex:[login length]], login, @"Expected to be equal");
    
}

@end
