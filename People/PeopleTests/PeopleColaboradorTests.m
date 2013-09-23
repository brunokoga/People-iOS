//
//  PeopleColaboradorTest.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.


#import <XCTest/XCTest.h>
#import "PeopleColaborador+PopulateFromServiceResponse.h"
#import "PeopleJSONParser.h"

@interface PeopleColaboradorTest : XCTestCase
@property (nonatomic, strong) NSArray *profiles;
@property (nonatomic, strong) NSArray *searches;

@end

@implementation PeopleColaboradorTest

- (void)setUp
{
    [super setUp];
    
    [self setUpProfileResults];
    [self setUpSearchResults];
}

- (void)setUpSearchResults
{
    PeopleJSONParser *parser = [[PeopleJSONParser alloc] init];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *searchJSON1Path = [bundle pathForResource:@"search_generic1" ofType:@"json"];
    NSData *searchJSON1Data = [NSData dataWithContentsOfFile:searchJSON1Path];
    NSDictionary *searchJSON1Dictionary = [NSJSONSerialization JSONObjectWithData:searchJSON1Data
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:nil];

    NSArray *searchColaboradoresArray1 = [parser colaboradoresArrayFromSearchResponse:searchJSON1Dictionary];
    
    NSString *searchJSON2Path = [bundle pathForResource:@"search_generic2" ofType:@"json"];
    NSData *searchJSON2Data = [NSData dataWithContentsOfFile:searchJSON2Path];
    NSDictionary *searchJSON2Dictionary = [NSJSONSerialization JSONObjectWithData:searchJSON2Data
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:nil];
    NSArray *searchColaboradoresArray2 = [parser colaboradoresArrayFromSearchResponse:searchJSON2Dictionary];
    
    
    self.searches = @[searchColaboradoresArray1, searchColaboradoresArray2];
    
}

- (void)setUpProfileResults
{
    PeopleJSONParser *parser = [[PeopleJSONParser alloc] init];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *profileJSON1Path = [bundle pathForResource:@"profile_generic1" ofType:@"json"];
    NSData *profileJSON1Data = [NSData dataWithContentsOfFile:profileJSON1Path];
    NSDictionary *profile1JSONDictionary = [NSJSONSerialization JSONObjectWithData:profileJSON1Data
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:nil];
    PeopleColaborador *colaborador1 = [parser colaboradorFromProfileResponse:profile1JSONDictionary];
    
    self.profiles = @[colaborador1];
}

- (void)tearDown
{
    self.profiles = nil;
    self.searches = nil;
    [super tearDown];
}

- (void)testColaboradoresFromSearchResponse
{
    for (NSArray *searchResult in self.searches)
    {
        for (PeopleColaborador *colaborador in searchResult)
        {
            XCTAssertNotNil(colaborador, @"Colaborador expected to be not nil");
            XCTAssertEqualObjects(colaborador.name, @"Nome", @"Wrong colaborador name");
            XCTAssertEqualObjects(colaborador.login, @"Login", @"Wrong colaborador login");
            XCTAssertEqualObjects(colaborador.mentorLogin, @"Mentor", @"Wrong colaborador's mentor login");
            XCTAssertEqualObjects(colaborador.role, @"Role", @"Wrong colaborador role");
            //   XCTAssertEqualObjects(colaborador.phone, @"0", @"Wrong colaborador phone");
            //            XCTAssertEqualObjects(colaborador.mobile, @"0", @"Wrong colaborador mobile");
            XCTAssertEqualObjects(colaborador.location, @"Base", @"Wrong colaborador location");
            XCTAssertEqualObjects(colaborador.managerLogin, @"Manager", @"Wrong colaborador's manager login");
        }
    }
    
}

- (void)testColaboradorFromProfileResponse
{
    for (PeopleColaborador *colaborador in self.profiles)
    {
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
        
        XCTAssert([colaborador.skills count] == 6, @"Unexpected value for colaborador skills count");
        for (int i = 1; i <= [colaborador.skills count]; i++)
        {
            NSString *skill = [@"Skill " stringByAppendingFormat:@"%d", i];
            NSDictionary *skillDictionary = colaborador.skills[skill];
            NSString *level = [@"Level da Skill " stringByAppendingFormat:@"%d", i];
            NSString *skillName = [@"Nome da Skill " stringByAppendingFormat:@"%d", i];
            NSString *years = [@"Anos da Skill " stringByAppendingFormat:@"%d", i];
            XCTAssertEqualObjects(skillDictionary[@"level"], level, @"Wrong colaborador skill level");
            XCTAssertEqualObjects(skillDictionary[@"skill"], skillName, @"Wrong colaborador skill name");
            XCTAssertEqualObjects(skillDictionary[@"years"], years, @"Wrong colaborador skill years");
        }
        
        XCTAssert([colaborador.pastProjects count] == 13, @"Unexpected value for colaborador past projects");
        for (int i = 1; i <= [colaborador.pastProjectsNames count]; i++)
        {
            NSString *project = [@"Nome do Projeto Passado " stringByAppendingFormat:@"%d", i];
            //     XCTAssertEqualObjects(colaborador.pastProjectsNames[i], project, @"Wrong colaborador past project name");
        }

        XCTAssert([colaborador.currentProjects count] == 2, @"Unexpected value for colaborador current projects");
        for (int i = 1; i <= [colaborador.currentProjectsNames count]; i++)
        {
            NSString *project = [@"Nome do Projeto Atual " stringByAppendingFormat:@"%d", i];
            XCTAssertEqualObjects(colaborador.currentProjectsNames[i-1], project, @"Wrong colaborador current project name");
        }
        
        XCTAssert([colaborador.teammates count] == 10, @"Unexpected value for colaborador teammates");
        NSMutableSet *teammates = [NSMutableSet set];
        for (int i = 1; i <= [colaborador.teammates count]; i++)
        {
            NSString *teammateLogin = [@"login_tm" stringByAppendingFormat:@"%d", i];
            NSString *teammateName = [@"Nome do Teammate " stringByAppendingFormat:@"%d", i];
            [teammates addObject:@{@"login" : teammateLogin,
                                   @"name" : teammateName}];
        }
        XCTAssertEqualObjects(colaborador.teammates, [NSSet setWithSet:teammates], @"Wrong colaborador teammates");
        
        XCTAssert([colaborador.socialNetworks count] == 3, @"Unexpected value for colaborador social networks");
        
        for (NSString *key in colaborador.socialNetworks)
        {
            NSString *socialNetworkLink;
            if ([key isEqualToString:@"linkedin"])
            {
                socialNetworkLink = @"www.linkdosociallink1.com";
            }
            else if ([key isEqualToString:@"twitter"])
            {
             socialNetworkLink = @"twitter.com/#!/twitter_username";
            }
            else if ([key isEqualToString:@"facebook"])
            {
                socialNetworkLink = @"www.facebook.com/facebook_username";
            }
            else
            {
                XCTFail(@"Should never be here");
            }
            XCTAssertEqualObjects(socialNetworkLink, [[colaborador.socialNetworks objectForKey:key] objectForKey:@"link"], @"Wrong colaborador social networks");
        }
        
    }
}

@end
