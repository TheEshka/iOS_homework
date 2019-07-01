//
//  NetworkService.h
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject<NSURLSessionDownloadDelegate, NetworkServiceIntputProtocol>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
