//
//  PeopleColaborador.m
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleColaborador.h"

@implementation PeopleColaborador

- (NSArray *)currentProjectsNames
{
    if ([self.currentProjects count] > 0)
    {
        return [self.currentProjects allKeys];
    }
    return @[];
}

- (NSArray *)pastProjectsNames
{
    if ([self.pastProjects count] > 0)
    {
        return [self.pastProjects allKeys];
    }
    return @[];
    
}

- (NSString *)description
{
    return self.login;
}

@end
