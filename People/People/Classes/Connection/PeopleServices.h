//
//  PeopleSearchProvider.h
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PeopleColaborador;

@interface PeopleServices : NSObject

+ (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
                  success:(void(^)(PeopleColaborador *colaborador))success
                  failure:(void(^)(NSError *error))failure;

+ (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                           success:(void(^)(NSArray *colaboradores))success
                           failure:(void(^)(NSError *error))failure;

+ (void)colaboradorProfileForLogin:(NSString *)login
                           success:(void(^)(PeopleColaborador *colaborador))success
                           failure:(void(^)(NSError *error))failure;

+ (void)photoForUser:(NSString *)user
             success:(void(^)(UIImage *image))success
             failure:(void(^)(NSError *error))failure;

+ (void)profileForUser:(NSString *)user
               success:(void (^)(PeopleColaborador *colarabor))success
               failure:(void (^)(NSError *error))failure;

@end
