//
//  PeopleSearchProvider.m
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleSearchProvider.h"
#import "PeopleHTTPClient.h"
#import "PeopleJSONParser.h"

@implementation PeopleSearchProvider

+ (instancetype)sharedProvider
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                        downloadSuccess:(void(^)(NSArray *colaboradores))success
                                failure:(void(^)(NSError *error))failure
{
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];
    
    [httpClient searchTerm:searchTerm
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
                       PeopleJSONParser *jsonParse = [[PeopleJSONParser alloc] init];
                       NSArray *colaboradores = [jsonParse colaboradoresArrayFromDictionary:json forResource:PeopleResourceSearch];
                       success(colaboradores);
                       
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       failure(error);
                       // 1 - offline
                   }];
}


@end
