//
//  SearchingModel.h
//  FlickerHomework
//
//  Created by Gagik on 24/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface SearchingModel : NSObject<ModelInputProtocol>

@property (nonatomic, weak)id<ModelOutputProtocol> changeDelegate;

@end

NS_ASSUME_NONNULL_END
