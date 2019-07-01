//
//  NetworkHelper.m
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "NetworkHelper.h"
#import "PhotoDetails.h"

static NSString *const APIKey = @"0f08fe534b6c22e567bd75ab8246a5ab";

@implementation NetworkHelper

+ (NSString *)URLForSearchString:(NSString *)searchString
{
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", APIKey, [self formatSearchString:searchString]];
}

+ (NSString *)URLForSearchString:(NSString *)searchString withPage:(NSInteger) page
{
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&page=%ld&format=json&nojsoncallback=1", APIKey, [self formatSearchString:searchString], page];
}


+ (NSString *)URLForGettingPhoto:(PhotoDetails *)photoParams
{
    return [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%@/%@_%@.jpg", (long)photoParams.farm, photoParams.server, photoParams.idNumber, photoParams.secret];
}



+ (NSString *)formatSearchString:(NSString *)searchString
{
    return [searchString stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

@end
