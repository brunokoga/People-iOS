//
//  PeopleJSONParse.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleJSONParser.h"

@implementation PeopleJSONParser

- (NSArray *)colaboradoresArrayFromSearchResponseDictionary:(NSDictionary *)responseDictionary
{
    NSArray *colaboradores = [PeopleColaborador colaboradoresFromSearchResponse:[responseDictionary objectForKey:@"data"]];
    return colaboradores;
}

- (PeopleColaborador *)colaboradorFromProfileResponseDictionary:(NSDictionary *)responseDictionary
{
    PeopleColaborador *colaborador = [PeopleColaborador colaboradorFromProfileResponse:responseDictionary];
    return colaborador;
}



@end
