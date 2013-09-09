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

+ (NSArray *)colaboradoresFromSearchResponse:(NSArray *)responseArray
{
    NSMutableArray *colaboradoresArray = [NSMutableArray array];
    for (NSArray *colaboradorArray in responseArray)
    {
        PeopleColaborador *colaborador = [[PeopleColaborador alloc] init];
        
        colaborador.name = colaboradorArray[0];
        colaborador.login = colaboradorArray[1];
        colaborador.phone = colaboradorArray[2];
        colaborador.mobile = colaboradorArray[3];
        colaborador.role = colaboradorArray[4];
        colaborador.mentorLogin = colaboradorArray[5];
        colaborador.managerLogin = colaboradorArray[6];
        colaborador.location = colaboradorArray[7];
        
        [colaboradoresArray addObject:colaborador];
    }
    
    return [NSArray arrayWithArray:colaboradoresArray];
}

+ (instancetype)colaboradorFromProfileResponse:(NSDictionary *)dirtyResponseDictionary
{
    //removing empty strings and [NSNull null] values
    ARSafeJSON *safeJSON = [[ARSafeJSON alloc] init];
    NSDictionary *responseDictionary = [safeJSON cleanUpJson:dirtyResponseDictionary];
    
    PeopleColaborador *colaborador = [[PeopleColaborador alloc] init];

    NSDictionary *colaboradorDictionary = responseDictionary[@"personal_info"];
    
    colaborador.birthday = colaboradorDictionary[@"birthday"];
    colaborador.building = colaboradorDictionary[@"building"];
    colaborador.email = colaboradorDictionary[@"email"];
    colaborador.joiningDate = colaboradorDictionary[@"joining_date"];
    colaborador.location = colaboradorDictionary[@"location"];
    colaborador.login = colaboradorDictionary[@"login"];
    colaborador.mobile = colaboradorDictionary[@"mobile"];
    colaborador.name = colaboradorDictionary[@"name"];
    colaborador.ownWords = colaboradorDictionary[@"own_words"];
    colaborador.phone = colaboradorDictionary[@"phone"];
    colaborador.role = colaboradorDictionary[@"role"];
    colaborador.managerLogin = colaboradorDictionary[@"manager_login"];
    colaborador.managerName = colaboradorDictionary[@"manager"];
    colaborador.mentorName = colaboradorDictionary[@"mentor"];
    colaborador.mentorLogin = colaboradorDictionary[@"mentor_login"];
    colaborador.skills = responseDictionary[@"skills"];
    
    NSDictionary *projectsDictionary = responseDictionary[@"projects"];
    colaborador.currentProjects = projectsDictionary[@"current"];
    colaborador.pastProjects = projectsDictionary[@"past"];
    colaborador.teammates = [NSSet setWithArray:[responseDictionary[@"teammates"] allValues]];
    
    NSArray *socialNetworksArray = [responseDictionary[@"employee_sociallinks"] allObjects];
    NSMutableDictionary *socialNetworks = [NSMutableDictionary dictionary];
    for (NSDictionary *socialNetwork in socialNetworksArray)
    {
        NSString *socialNetworkName = socialNetwork[@"name"];
        NSString *socialNetworkLink = socialNetwork[@"link"];
        NSString *socialNetworkLogo = socialNetwork[@"logo"];
        
        [socialNetworks setObject:@{@"link" : socialNetworkLink,
                                    @"logo" : socialNetworkLogo}
                           forKey:socialNetworkName];
    }
    colaborador.socialNetworks = [NSDictionary dictionaryWithDictionary:socialNetworks];
    
    return colaborador;
    
}

@end
