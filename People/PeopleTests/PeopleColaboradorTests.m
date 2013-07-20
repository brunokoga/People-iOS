//
//  PeopleColaboradorTest.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.


#import <XCTest/XCTest.h>
#import "PeopleColaborador+PopulateFromServiceResponse.h"

@interface PeopleColaboradorTest : XCTestCase
@property (nonatomic, strong) NSArray *profileJSONs;
@property (nonatomic, strong) NSArray *searchResultJSONs;

@end

@implementation PeopleColaboradorTest

- (void)setUp
{
    [super setUp];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *profileJSON1Path = [bundle pathForResource:@"profile_generic1" ofType:@"json"];
    NSData *profileJSON1Data = [NSData dataWithContentsOfFile:profileJSON1Path];
    NSDictionary *profileJSON1 = [NSJSONSerialization JSONObjectWithData:profileJSON1Data options:NSJSONReadingAllowFragments error:nil];
    
    self.profileJSONs = @[profileJSON1];
    
}

- (void)tearDown
{
    self.profileJSONs = nil;
    self.searchResultJSONs = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testColaboradorFromProfileResponse
{
    for (NSDictionary *jsonDictionary in self.profileJSONs)
    {
        PeopleColaborador *colaborador = [PeopleColaborador colaboradorFromProfileResponse:jsonDictionary];
        XCTAssertNotNil(colaborador, @"Colaborador expected to be not nil");
        XCTAssertEqualObjects(colaborador.name, @"Nome do Colaborador", @"Wrong colaborador name");
        XCTAssertEqualObjects(colaborador.login, @"Login do Colaborador", @"Wrong colaborador login");
        XCTAssertEqualObjects(colaborador.mentorLogin, @"Login do Mentor", @"Wrong colaborador's mentor login");
        XCTAssertEqualObjects(colaborador.mentorName, @"Nome do Mentor", @"Wrong colaborador's mentor name");
        XCTAssertEqualObjects(colaborador.role, @"Papel do Colaborador", @"Wrong colaborador role");
        XCTAssertEqualObjects(colaborador.email, @"email@ciandt.com", @"Wrong colaborador email");
        XCTAssertEqualObjects(colaborador.location, @"Base do Colaborador", @"Wrong colaborador location");
        XCTAssertEqualObjects(colaborador.managerName, @"Nome do Gerente", @"Wrong colaborador's manager name");
        XCTAssertEqualObjects(colaborador.managerLogin, @"Login do Gerente", @"Wrong colaborador's manager login");
        XCTAssertEqualObjects(colaborador.phone, @"Telefone do Colaborador", @"Wrong colaborador phone");
        XCTAssertEqualObjects(colaborador.mobile, @"Celular do Colaborador", @"Wrong colaborador mobile");
        XCTAssertEqualObjects(colaborador.ownWords, @"Own Words", @"Wrong colaborador own words");
        XCTAssertEqualObjects(colaborador.birthday, @[], @"Wrong colaborador birthday");
        XCTAssertEqualObjects(colaborador.joiningDate, @"03-01-11", @"Wrong colaborador joining date");
        XCTAssertNil(colaborador.building, @"Wrong colaborador building");
    }
}

@end
