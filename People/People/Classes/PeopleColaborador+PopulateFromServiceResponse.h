//
//  PeopleColaborador+PopulateFromServiceResponse.h
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleColaborador.h"

@interface PeopleColaborador (PopulateFromServiceResponse)

+ (NSArray *)colaboradoresFromSearchResponse:(NSArray *)responseArray;
+ (instancetype)colaboradorFromProfileResponse:(NSDictionary *)responseDictionary;

@end
