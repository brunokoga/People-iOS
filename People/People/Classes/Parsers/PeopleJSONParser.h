//
//  PeopleJSONParse.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PeopleResource {
    PeopleResourceSearch = 0,
    PeoplePhotoSearch = 1,
    PeopleResourceProfile = 2
} PeopleResource;

@interface PeopleJSONParser : NSObject

- (NSArray *)colaboradoresArrayFromDictionary:(NSDictionary *)dictionary forResource:(PeopleResource)resource;

@end
