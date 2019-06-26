//
//  NetworkHelper.m
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper

+ (NSString *)URLForSearchString:(NSString *)searchString
{
    NSString *APIKey = @"0f08fe534b6c22e567bd75ab8246a5ab";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", APIKey, searchString];
}

+ (NSString *)URLForGettingPhoto:(NSDictionary *)photoParams
{
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photoParams[@"farm"], photoParams[@"server"],photoParams[@"id"],photoParams[@"secret"]];
}

@end
