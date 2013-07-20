//
//  PeopleSearchProvider.h
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleColaborador.h"

@interface PeopleServices : NSObject

+ (instancetype)sharedProvider;

- (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                        downloadSuccess:(void(^)(NSArray *colaboradores))success
                                failure:(void(^)(NSError *error))failure;

- (void)colaboradorProfileForLogin:(NSString *)login
                                  downloadSuccess:(void(^)(PeopleColaborador *colaborador))success
                                          failure:(void(^)(NSError *error))failure;


@end
