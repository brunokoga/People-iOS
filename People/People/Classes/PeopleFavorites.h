//
//  PeopleFavorites.h
//  People
//
//  Created by Bruno Koga on 7/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleFavorites : NSObject

+ (NSArray *)allFavoriteColaboradores;
+ (void)addFavoriteWithLogin:(NSString *)login;
+ (void)removeFavoriteWithLogin:(NSString *)login;

@end
