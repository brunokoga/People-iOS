//
//  PeopleHTTPClient.m
//  People
//
//  Created by Bruno Koga on 4/27/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleHTTPClient.h"
#import <FormatterKit/TTTURLRequestFormatter.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@implementation PeopleHTTPClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        NSURL *baseURL = [self baseURL];
        sharedInstance = [[self alloc] initWithBaseURL:baseURL];
    });
    return sharedInstance;
}

static NSString * const kPeopleBaseURL = @"https://people.cit.com.br/";


+ (NSURL *)baseURL
{
    NSURL *baseURL = [NSURL URLWithString:kPeopleBaseURL];
    return  baseURL;
}

- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation
{
#ifdef DEBUG
    NSLog(@"%@\n\n", [TTTURLRequestFormatter cURLCommandFromURLRequest:operation.request]);
#endif
    [super enqueueHTTPRequestOperation:operation];
}

#pragma mark - Authentication

- (void)setUsername:(NSString *)username
           password:(NSString *)password;
{
    [self clearAuthorizationHeader];    
    [self setAuthorizationHeaderWithUsername:username
                                    password:password];
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(PeopleRequestOperationBlockSuccess)success
                  failure:(PeopleRequestOperationBlockFailure)failure
{
    /*
     There is no Login service for People
     Use just search for the username passed on the login
     */
    
    NSString *loginProfileUser = [self profileEndpointForUser:username];
    
    [self setUsername:username
             password:password];
    
    [self getPath:loginProfileUser
       parameters:nil
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // if there is an error, we reset the password
              [self clearAuthorizationHeader];
              failure(operation, error);
          }];
}

- (void)logout
{
    [self clearAuthorizationHeader];
}

#pragma mark - Endpoints

- (NSString *)searchEndpointForTerm:(NSString *)term
{
    NSString *endpoint = [@"search/json/?q=" stringByAppendingString:term];
    endpoint = [endpoint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return endpoint;
}

- (NSString *)photoEndpointForUser:(NSString *)user
{
    NSString *endpoint = [@"photos/" stringByAppendingString:user];
    endpoint = [endpoint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return endpoint;
    
}

- (NSString *)profileEndpointForUser:(NSString *)user
{
    NSString *endpoint = [@"profile/" stringByAppendingFormat:@"%@?format=json", user];
    endpoint = [endpoint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return endpoint;
}

#pragma mark - Services

- (void)searchTerm:(NSString *)term
           success:(PeopleRequestOperationBlockSuccess)success
           failure:(PeopleRequestOperationBlockFailure)failure
{
    NSString *searchEndpoint = [self searchEndpointForTerm:term];

    [self getPath:searchEndpoint
       parameters:nil
          success:success
          failure:failure];
}

- (void)profileForUser:(NSString *)user
               success:(PeopleRequestOperationBlockSuccess)success
               failure:(PeopleRequestOperationBlockFailure)failure
{
    NSString *profileEndpoint = [self profileEndpointForUser:user];
    
    [self getPath:profileEndpoint
       parameters:nil
          success:success
          failure:failure];
}

- (void)photoForUser:(NSString *)user
               success:(PeopleRequestOperationBlockSuccess)success
               failure:(PeopleRequestOperationBlockFailure)failure
{
    NSString *photoEndpoint = [self photoEndpointForUser:user];
    
    [self getPath:photoEndpoint
       parameters:nil
          success:success
          failure:failure];
}

@end
