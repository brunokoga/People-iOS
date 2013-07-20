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
        
        colaborador.name = [colaboradorArray objectAtIndex:0];
        colaborador.login = [colaboradorArray objectAtIndex:1];
        colaborador.phone = [colaboradorArray objectAtIndex:2];
        colaborador.mobile = [colaboradorArray objectAtIndex:3];
        colaborador.role = [colaboradorArray objectAtIndex:4];
        colaborador.mentorLogin = [colaboradorArray objectAtIndex:5];
        colaborador.managerLogin = [colaboradorArray objectAtIndex:6];
        colaborador.location = [colaboradorArray objectAtIndex:7];
        
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
    colaborador.teammates = [NSSet setWithArray:[[responseDictionary objectForKey:@"teammates"] allValues]];
    
    NSArray *socialNetworksArray = [[responseDictionary objectForKey:@"employee_sociallinks"] allObjects];
    NSMutableDictionary *socialNetworks = [NSMutableDictionary dictionary];
    for (NSDictionary *socialNetwork in socialNetworksArray)
    {
        NSString *socialNetworkName = [socialNetwork objectForKey:@"name"];
        NSString *socialNetworkLink = [socialNetwork objectForKey:@"link"];
        NSString *socialNetworkLogo = [socialNetwork objectForKey:@"logo"];
        
        [socialNetworks setObject:@{@"link" : socialNetworkLink,
                                    @"logo" : socialNetworkLogo}
                           forKey:socialNetworkName];
    }
    colaborador.socialNetworks = [NSDictionary dictionaryWithDictionary:socialNetworks];
    
    
    
    
    
    
    
    
    
    
    
    


    
    return colaborador;
    
}

@end
