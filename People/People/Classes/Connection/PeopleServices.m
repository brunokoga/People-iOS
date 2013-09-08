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

+ (instancetype)sharedServices
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                           success:(void(^)(NSArray *colaboradores))success
                           failure:(void(^)(NSError *error))failure
{
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];
    
    [httpClient searchTerm:searchTerm
                   success:^(NSHTTPURLResponse *response, id responseObject) {
                       PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                       NSArray *colaboradores = [jsonParser colaboradoresArrayFromSearchResponse:responseObject];
                       success(colaboradores);
                       
                   } failure:^(NSError *error) {
                       failure(error);
                       // 1 - offline
                   }];
}

- (void)colaboradorProfileForLogin:(NSString *)login
                           success:(void(^)(PeopleColaborador *colaborador))success
                           failure:(void(^)(NSError *error))failure
{
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];

    [httpClient profileForUser:login
                       success:^(NSHTTPURLResponse *response, id responseObject) {
                           PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                           PeopleColaborador *colaborador = [jsonParser colaboradorFromProfileResponse:responseObject];
                           success(colaborador);
                           
                       } failure:^(NSError *error) {
                           failure(error);
                           // 1 - offline
                       }];
}

- (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
                  success:(void(^)(PeopleColaborador *colaborador))success
                  failure:(void(^)(NSError *error))failure
{
    PeopleHTTPClient *httpClient = [PeopleHTTPClient sharedClient];
    [httpClient loginWithUsername:user
                         password:password
                          success:^(NSHTTPURLResponse *response, id responseObject) {
                              PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                              PeopleColaborador *colaborador = [jsonParser colaboradorFromProfileResponse:responseObject];
                              
                              //if there is no colaboradores or more than 1, something went wrong
                              if (colaborador)
                              {
                                  success(colaborador);
                              }
                              else
                              {
                                  NSError *error = [NSError errorWithDomain:@"com.ciant.people.login" code:0 userInfo:nil];
                                  failure(error);
                              }
                              
                          } failure:^(NSError *error) {
                              failure(error);
                          }];
}

@end
