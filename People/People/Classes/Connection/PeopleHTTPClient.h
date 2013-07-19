//
//  PeopleHTTPClient.h
//  People
//
//  Created by Bruno Koga on 4/27/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import <AFNetworking/AFHTTPClient.h>

typedef enum PeopleConnectionError2 {
    ErrorOperationCouldntBePerformed = 256,
    ErrorCouldntCreate = 3840
} PeopleConnectionError2;

typedef void (^PeopleRequestOperationBlockSuccess) (AFHTTPRequestOperation *operation, id responseObject);
typedef void (^PeopleRequestOperationBlockFailure) (AFHTTPRequestOperation *operation, NSError *error);

@interface PeopleHTTPClient : AFHTTPClient

+ (instancetype)sharedClient;

#pragma mark - Authentication

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(PeopleRequestOperationBlockSuccess)success
                  failure:(PeopleRequestOperationBlockFailure)failure;

- (void)setUsername:(NSString *)username
           password:(NSString *)password;

- (void)logout;

#pragma mark - Search
- (void)searchTerm:(NSString *)term
           success:(PeopleRequestOperationBlockSuccess)success
           failure:(PeopleRequestOperationBlockFailure)failure;

#pragma mark - Profile
- (void)profileForUser:(NSString *)user
               success:(PeopleRequestOperationBlockSuccess)success
               failure:(PeopleRequestOperationBlockFailure)failure;

#pragma mark - Photo
- (void)photoForUser:(NSString *)user
             success:(PeopleRequestOperationBlockSuccess)success
             failure:(PeopleRequestOperationBlockFailure)failure;

@end
