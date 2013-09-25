//
//  PeopleHTTPSessionManager.h
//  People
//
//  Created by Christian Sampaio on 9/25/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum PeopleConnectionError {
    ErrorOperationCouldntBePerformed = 256,
    ErrorCouldntCreate = 3840
} PeopleConnectionError;

typedef void (^PeopleRequestOperationBlockSuccess) (NSURLSessionDataTask *task, id responseObject);
typedef void (^PeopleRequestOperationBlockFailure) (NSError *error);

@interface PeopleHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

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
