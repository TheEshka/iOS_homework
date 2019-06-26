//
//  PhotoDetails.h
//  FlickerHomework
//
//  Created by Gagik on 26/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetails : NSObject

@property (nonatomic, strong)NSString *owner;
@property (nonatomic, strong)NSString *secret;
@property (nonatomic, strong)NSString *server;
@property (nonatomic, strong)NSString *idNumber;
@property (nonatomic, assign)NSInteger farm;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger isFriend;
@property (nonatomic, assign)NSInteger isFamily;
@property (nonatomic, assign)NSInteger isPublic;

@end

NS_ASSUME_NONNULL_END
