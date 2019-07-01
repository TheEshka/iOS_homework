//
//  SearchingHistory.m
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "SearchingHistory.h"

static NSString *const searchesKey = @"allSearchesArray";

@implementation SearchingHistory

+ (void)addSearchText:(NSString *)searchedText
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *searchesArray = [[userDefaults arrayForKey:searchesKey] mutableCopy];
    if (!searchesArray)
    {
        searchesArray = [[NSMutableArray alloc] init];
    }
    for (NSString *string in searchesArray) {
        if ([string isEqualToString:searchedText])
            return;
    }
    [searchesArray addObject:searchedText];
    [userDefaults setObject:searchesArray forKey:searchesKey];
}

+ (NSArray *)getSearchesStartingWith:(NSString *)startString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *searchesArray = [userDefaults arrayForKey:searchesKey];
    if ([startString  isEqual: @""])
    {
        return searchesArray;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[cd] %@", startString];
    NSArray *felteredArray = [searchesArray filteredArrayUsingPredicate:predicate];
    return felteredArray;
}

+ (NSString *)getRandomSearch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *searchesArray = [userDefaults arrayForKey:searchesKey];
    NSInteger num = arc4random() % searchesArray.count;
    return searchesArray[num];
}

@end
