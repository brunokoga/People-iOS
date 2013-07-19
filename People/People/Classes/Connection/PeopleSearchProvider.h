//
//  PeopleSearchProvider.h
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleSearchProvider : NSObject

+ (instancetype)sharedProvider;

- (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                        downloadSuccess:(void(^)(NSArray *colaboradores))success
                                failure:(void(^)(NSError *error))failure;


@end
