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
    NSError *serializationError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:serviceResponse options:NSUTF8StringEncoding error:&serializationError];
    
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
    NSError *serializationError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:serviceResponse options:NSUTF8StringEncoding error:&serializationError];
    PeopleColaborador *colaborador = [PeopleColaborador colaboradorFromProfileResponse:responseDictionary];
    return colaborador;
}



@end
