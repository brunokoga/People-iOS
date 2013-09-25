//
//  PeopleHTTPSessionManager.m
//  People
//
//  Created by Christian Sampaio on 9/25/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleHTTPSessionManager.h"
#import <FormatterKit/TTTURLRequestFormatter.h>

@implementation PeopleHTTPSessionManager

+ (instancetype)sharedManager
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

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFImageResponseSerializer serializer];
    return [super initWithBaseURL:url];
}

//- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation
//{
//#ifdef DEBUG
//    NSLog(@"%@\n\n", [TTTURLRequestFormatter cURLCommandFromURLRequest:operation.request]);
//#endif
//    [super enqueueHTTPRequestOperation:operation];
//}

#pragma mark - Authentication

- (void)setUsername:(NSString *)username
           password:(NSString *)password
{
    AFHTTPRequestSerializer *serializer = self.requestSerializer;
    [serializer clearAuthorizationHeader];
    [serializer setAuthorizationHeaderFieldWithUsername:username
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
    
    [self GET:loginProfileUser
   parameters:nil
      success:success
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          
          // if there is an error, we reset the password
          
          AFHTTPRequestSerializer *serializer = self.requestSerializer;
          [serializer clearAuthorizationHeader];
          failure(error);
      }];
}

- (void)logout
{
    [self.requestSerializer clearAuthorizationHeader];
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
    
    [self GET:searchEndpoint
   parameters:nil
      success:success
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}

- (void)profileForUser:(NSString *)user
               success:(PeopleRequestOperationBlockSuccess)success
               failure:(PeopleRequestOperationBlockFailure)failure
{
    NSString *profileEndpoint = [self profileEndpointForUser:user];
    
    [self GET:profileEndpoint
   parameters:nil
      success:success
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];}

- (void)photoForUser:(NSString *)user
             success:(PeopleRequestOperationBlockSuccess)success
             failure:(PeopleRequestOperationBlockFailure)failure
{
    NSString *photoEndpoint = [self photoEndpointForUser:user];
    
    [self GET:photoEndpoint
   parameters:nil
      success:success
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure(error);
      }];
}


@end
