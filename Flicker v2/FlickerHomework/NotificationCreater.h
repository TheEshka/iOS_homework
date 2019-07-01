//
//  NotificationCreater.h
//  FlickerHomework
//
//  Created by Gagik on 01/07/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationCreater : NSObject

+ (NotificationCreater *)sharedInstance;
- (void)setInactive;

- (void)sheduleLocalNotification;

@end

NS_ASSUME_NONNULL_END
