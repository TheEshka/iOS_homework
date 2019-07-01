//
//  NotificationCreater.m
//  FlickerHomework
//
//  Created by Gagik on 01/07/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "NotificationCreater.h"
#import "SearchingHistory.h"

@import UIKit;
@import UserNotifications;

static NSString *const identifierForActions = @"LCTReminderCategory";
typedef NS_ENUM(NSInteger, LCTTriggerType) {
    LCTTriggerTypeInterval = 0,
    LCTTriggerTypeDate = 1,
    LCTTriggerTypeLocation = 2,
};

@interface NotificationCreater ()

@property (nonatomic, assign)BOOL active;

@end

@implementation NotificationCreater

+ (NotificationCreater *)sharedInstance {
    static NotificationCreater *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.active = YES;
    });
    
    return sharedInstance;
}

- (void)setInactive
{
    self.active = NO;
}

#pragma mark - LocalNotifications

- (void)sheduleLocalNotification
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    NSString *searchString = [SearchingHistory getRandomSearch];
    
    content.title = @"Напоминание!";
    content.body = [NSString stringWithFormat:@"Посмотри картинки %@", searchString];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([self giveNewBadgeNumber] + 1);
    
//    UNNotificationAttachment *attachment = [self imageAttachment];
//    if (attachment)
//    {
//        content.attachments = @[attachment];
//    }
    
    NSDictionary *dict = @{
                           @"searchString": searchString
                           };
    content.userInfo = dict;
    
    content.categoryIdentifier = identifierForActions;
    UNNotificationTrigger *whateverTrigger = [self intervalTrigger:5];
    
    NSString *identifier = @"NotificationId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:whateverTrigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Чот пошло не так... %@",error);
         }
     }];
}


#pragma mark - NotificationsTypes

- (UNTimeIntervalNotificationTrigger *)intervalTrigger:(NSTimeInterval)interval
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
}

- (UNCalendarNotificationTrigger *)dateTrigger
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3600];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:date];
    
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
}

- (UNLocationNotificationTrigger *)locationTrigger
{
    /*
     // Создаем или получаем CLRegion и заводим триггер
     return [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
     */
    return nil;
}


#pragma mark - ContentType

- (NSInteger)giveNewBadgeNumber
{
    return [UIApplication sharedApplication].applicationIconBadgeNumber;
}

@end
