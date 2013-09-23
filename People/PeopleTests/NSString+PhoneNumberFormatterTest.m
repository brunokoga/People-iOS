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

- (void)testExample
{
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testPhoneNumberFormat
{
    NSString *phone = @"4500";
    NSString *formattedNumber = [phone phoneNumberFormat];
    XCTAssertEqualObjects(formattedNumber, @"1921024500", @"Wrong!");
    
}

- (void)testCiandtEmailWithFocusOnLogin
{
    NSString *login = @"mylogin";
    NSAttributedString *email = [login ciandtEmailWithFocusOnLogin];
    XCTAssertNil(email, @"Expected to be nil");
}

@end
