//
//  PeopleJSONParse.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleJSONParser.h"

@implementation PeopleJSONParser

- (NSArray *)colaboradoresArrayFromSearchResponse:(id)serviceResponse;
{
    NSDictionary *responseDictionary = serviceResponse;
    
    NSArray *responseData = [responseDictionary objectForKey:@"data"];
    NSArray *colaboradores = @[];
    if ([responseData isKindOfClass:[NSArray class]])
    {
        colaboradores = [PeopleColaborador colaboradoresFromSearchResponse:responseData];
    }
    return colaboradores;
}

- (PeopleColaborador *)colaboradorFromProfileResponse:(id)serviceResponse;
{
    PeopleColaborador *colaborador = [PeopleColaborador colaboradorFromProfileResponse:serviceResponse];
    return colaborador;
}



@end
