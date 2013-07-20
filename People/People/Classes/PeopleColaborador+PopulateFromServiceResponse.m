//
//  PeopleColaborador+PopulateFromServiceResponse.m
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleColaborador+PopulateFromServiceResponse.h"
#import <ARSafeJSON/ARSafeJSON.h>

@implementation PeopleColaborador (PopulateFromServiceResponse)

+ (instancetype)colaboradorFromSearchResponse:(NSArray *)responseArray
{
    PeopleColaborador *colaborador = [[PeopleColaborador alloc] init];
    
    colaborador.name = [responseArray objectAtIndex:0];
    colaborador.login = [responseArray objectAtIndex:1];
    colaborador.phone = [responseArray objectAtIndex:2];
    colaborador.mobile = [responseArray objectAtIndex:3];
    colaborador.role = [responseArray objectAtIndex:4];
    colaborador.mentorLogin = [responseArray objectAtIndex:5];
    colaborador.managerLogin = [responseArray objectAtIndex:6];
    colaborador.location = [responseArray objectAtIndex:7];
    
    return colaborador;
}

+ (instancetype)colaboradorFromProfileResponse:(NSDictionary *)dirtyResponseDictionary
{
    //removing empty strings and [NSNull null] values
    ARSafeJSON *safeJSON = [[ARSafeJSON alloc] init];
    NSDictionary *responseDictionary = [safeJSON cleanUpJson:dirtyResponseDictionary];
    
    PeopleColaborador *colaborador = [[PeopleColaborador alloc] init];

    NSArray *socialNetworks = [responseDictionary objectForKey:@"employee_sociallinks"];
    colaborador.socialNetworks = socialNetworks;
    
    NSDictionary *colaboradorDictionary = [responseDictionary objectForKey:@"personal_info"];
    
    colaborador.birthday = [colaboradorDictionary objectForKey:@"birthday"];
    colaborador.building = [colaboradorDictionary objectForKey:@"building"];
    colaborador.email = [colaboradorDictionary objectForKey:@"email"];
    colaborador.joiningDate = [colaboradorDictionary objectForKey:@"joining_date"];
    colaborador.location = [colaboradorDictionary objectForKey:@"location"];
    colaborador.login = [colaboradorDictionary objectForKey:@"login"];
    colaborador.mobile = [colaboradorDictionary objectForKey:@"mobile"];
    colaborador.name = [colaboradorDictionary objectForKey:@"name"];
    colaborador.ownWords = [colaboradorDictionary objectForKey:@"own_words"];
    colaborador.phone = [colaboradorDictionary objectForKey:@"phone"];
    colaborador.role = [colaboradorDictionary objectForKey:@"role"];
    colaborador.managerLogin = [colaboradorDictionary objectForKey:@"manager_login"];
    colaborador.managerName = [colaboradorDictionary objectForKey:@"manager"];
    colaborador.mentorName = [colaboradorDictionary objectForKey:@"mentor"];
    colaborador.mentorLogin = [colaboradorDictionary objectForKey:@"mentor_login"];
    colaborador.skills = [responseDictionary objectForKey:@"skills"];
    
    NSDictionary *projectsDictionary = [responseDictionary objectForKey:@"projects"];
    colaborador.currentProjects = [projectsDictionary objectForKey:@"current"];
    colaborador.pastProjects = [projectsDictionary objectForKey:@"past"];
    
    // teammates
    NSMutableArray *teammatesNames = [[NSMutableArray alloc] init];
    NSMutableArray *teammatesLogins = [[NSMutableArray alloc] init];
    NSDictionary *teammates = [responseDictionary objectForKey:@"teammates"];
    
    for (NSString *login in teammates) {
        NSDictionary *teamMember = [teammates objectForKey:login];
        [teammatesNames addObject:[teamMember objectForKey:@"name"]];
        [teammatesLogins addObject:[teamMember objectForKey:@"login"]];
    }
    colaborador.teammatesNames = [NSArray arrayWithArray:teammatesNames];
    colaborador.teammatesLogins = [NSArray arrayWithArray:teammatesLogins];
    
    return colaborador;
    
}

@end
