//
//  PeopleSearchProvider.m
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleServices.h"
#import "PeopleHTTPClient.h"
#import "PeopleJSONParser.h"

@implementation PeopleServices

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
                       PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                       NSArray *colaboradores = [jsonParser colaboradoresArrayFromSearchResponse:responseObject];
                       success(colaboradores);
                       
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       failure(error);
                       // 1 - offline
                   }];
}

- (void)colaboradorProfileForLogin:(NSString *)login
                                  downloadSuccess:(void(^)(PeopleColaborador *colaborador))success
                                          failure:(void(^)(NSError *error))failure
{
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];

    [httpClient profileForUser:login
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                           PeopleColaborador *colaborador = [jsonParser colaboradorFromProfileResponse:responseObject];
                           success(colaborador);
                           
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           failure(error);
                           // 1 - offline
                       }];
}



@end
