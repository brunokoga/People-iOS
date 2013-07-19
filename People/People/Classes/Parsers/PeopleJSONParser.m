//
//  PeopleJSONParse.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleJSONParser.h"
#import "PeopleColaborador+PopulateFromServiceResponse.h"

@implementation PeopleJSONParser

- (NSArray *)colaboradoresArrayFromDictionary:(NSDictionary *)dictionary forResource:(PeopleResource)resource;
{
    NSArray *json;
    NSMutableArray *listOfCollaborators = [[NSMutableArray alloc] init];
    
    switch (resource) {
        case PeopleResourceSearch:
            json = [dictionary objectForKey:@"data"];
                for (NSArray *array in json)
                {
                    [listOfCollaborators addObject:[PeopleColaborador colaboradorFromSearchResponse:array]];
                }
            break;
        case PeopleResourceProfile:
            [listOfCollaborators addObject:[PeopleColaborador colaboradorFromProfileResponse:dictionary]];
            break;
        default:
            break;
    }
    
    NSArray *collaboratorsToReturn = [NSArray arrayWithArray:listOfCollaborators];
    return collaboratorsToReturn;
}



@end
