//
//  PeopleFavorites.m
//  People
//
//  Created by Bruno Koga on 7/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleFavorites.h"
#import "PeopleColaborador.h"
#import "PeoplePreferences.h"

@implementation PeopleFavorites

+ (NSArray *)allFavoriteColaboradores
{
    NSString *username = [PeoplePreferences username];
    if (!username) return nil;
    return nil;
}

static NSString * const kFavoritesColaboradoresForAllUsers = @"kFavoritesColaboradoresForAllUsers";


+ (void)addFavoriteWithLogin:(NSString *)login
{
    NSString *username = [PeoplePreferences username];
    if (!username) return;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *allFavorites = [standardUserDefaults objectForKey:kFavoritesColaboradoresForAllUsers];
    NSSet *favoritesForUser = [allFavorites objectForKey:username];
    NSMutableSet *mutableFavoritesForUser = [favoritesForUser mutableCopy];
    [mutableFavoritesForUser addObject:login];
    
    NSMutableDictionary *mutableAllFavorites = [allFavorites mutableCopy];
    [mutableAllFavorites setObject:mutableFavoritesForUser forKey:login];
    [standardUserDefaults setObject:mutableAllFavorites forKey:kFavoritesColaboradoresForAllUsers];
    [standardUserDefaults synchronize];
}

+ (void)removeFavoriteWithLogin:(NSString *)login
{
    NSString *username = [PeoplePreferences username];
    if (!username) return;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *allFavorites = [standardUserDefaults objectForKey:kFavoritesColaboradoresForAllUsers];
    NSSet *favoritesForUser = [allFavorites objectForKey:username];
    NSMutableSet *mutableFavoritesForUser = [favoritesForUser mutableCopy];
    [mutableFavoritesForUser removeObject:login];

    NSMutableDictionary *mutableAllFavorites = [allFavorites mutableCopy];
    [mutableAllFavorites setObject:mutableFavoritesForUser forKey:login];
    [standardUserDefaults setObject:mutableAllFavorites forKey:kFavoritesColaboradoresForAllUsers];
    [standardUserDefaults synchronize];
}



@end
