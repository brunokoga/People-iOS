//
//  PeopleSearchProvider.m
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleServices.h"
#import "PeopleHTTPSessionManager.h"
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
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    
    [session searchTerm:searchTerm
                success:^(NSURLSessionDataTask *task, id responseObject) {
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
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];

    [session profileForUser:login
                    success:^(NSURLSessionDataTask *task, id responseObject) {
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
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session loginWithUsername:user
                      password:password
                       success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)photoForUser:(NSString *)user
             success:(void(^)(UIImage *image))success
             failure:(void(^)(NSError *error))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session photoForUser:user
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      UIImage *responseImage = [UIImage imageWithData:responseObject];
                      success(responseImage);
                  } failure:^(NSError *error) {
                      failure(error);
                  }];
}

- (void)profileForUser:(NSString *)user
               success:(void (^)(PeopleColaborador *))success
               failure:(void (^)(NSError *))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session profileForUser:user
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                        PeopleColaborador *colaboradorProfile = [jsonParser colaboradorFromProfileResponse:responseObject];
                        success(colaboradorProfile);
                        
                    } failure:failure];
}



@end
