//
//  NetworkHelper.h
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PhotoDetails;

@interface NetworkHelper : NSObject

+ (NSString *)URLForSearchString:(NSString *)searchString;
+ (NSString *)URLForSearchString:(NSString *)searchString withPage:(NSInteger) page;
+ (NSString *)URLForGettingPhoto:(PhotoDetails *)photoParams;

@end

NS_ASSUME_NONNULL_END
