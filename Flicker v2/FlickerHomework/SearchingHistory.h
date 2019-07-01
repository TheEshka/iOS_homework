//
//  SearchingHistory.h
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchingHistory : NSObject

+ (void)addSearchText:(NSString *)searchedText;
+ (NSArray *)getSearchesStartingWith:(NSString *)startString;

+ (NSString *)getRandomSearch;

@end

NS_ASSUME_NONNULL_END
