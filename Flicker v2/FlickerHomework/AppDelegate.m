//
//  AppDelegate.m
//  FlickerHomework
//
//  Created by Gagik on 22/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerProtocol.h"
#import "NotificationCreater.h"

@import UserNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // наверное не правльно каждый раз запрашивать, как лучше сделать?
    NotificationCreater *notificationCreater = [NotificationCreater sharedInstance];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted)
                              {
                                  [notificationCreater setInactive];
                              }
                          }];
    /*
     // А вот так можно проверить, не изменил ли пользователь настройки для пушей
     [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
     if (settings.authorizationStatus != UNAuthorizationStatusAuthorized)
     {
     // Нет доступа
     }
     }];
     */
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NotificationCreater *notificationCreater = [NotificationCreater sharedInstance];
    [notificationCreater sheduleLocalNotification];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
willPresentNotification:(UNNotification *)notification
withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    if (completionHandler)
    {
        completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"searchString"])
    {
        NSString *searchText = content.userInfo[@"searchString"];
        id<ViewControllerInputProtocol> viewController= self.window.rootViewController;
        [viewController instantSearch:searchText];
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}

@end
