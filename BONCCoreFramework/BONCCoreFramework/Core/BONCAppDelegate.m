/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>
#import "BONCAppDelegate.h"
#import "BONCCore.h"
#import "BONCModuleManager.h"
#import "BONCTimeProfiler.h"
#import "BONCContext.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif


@interface BONCAppDelegate ()

@end

@implementation BONCAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[BONCModuleManager sharedManager] triggerEvent:BONCMSetupEvent];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMInitEvent];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[BONCModuleManager sharedManager] triggerEvent:BONCMSplashEvent];
    });
    
#ifdef DEBUG
    [[BONCTimeProfiler sharedTimeProfiler] saveTimeProfileDataIntoFile:@"BeeHiveTimeProfiler"];
#endif
    
    return YES;
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400 

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [[BONCCore shareInstance].context.touchShortcutItem setShortcutItem: shortcutItem];
    [[BONCCore shareInstance].context.touchShortcutItem setScompletionHandler: completionHandler];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMQuickActionEvent];
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMWillResignActiveEvent];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidEnterBackgroundEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMWillEnterForegroundEvent];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidBecomeActiveEvent];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMWillTerminateEvent];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[BONCCore shareInstance].context.openURLItem setOpenURL:url];
    [[BONCCore shareInstance].context.openURLItem setSourceApplication:sourceApplication];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMOpenURLEvent];
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
  
    [[BONCCore shareInstance].context.openURLItem setOpenURL:url];
    [[BONCCore shareInstance].context.openURLItem setOptions:options];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMOpenURLEvent];
    return YES;
}
#endif


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidReceiveMemoryWarningEvent];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[BONCCore shareInstance].context.notificationsItem setNotificationsError:error];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidFailToRegisterForRemoteNotificationsEvent];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[BONCCore shareInstance].context.notificationsItem setDeviceToken: deviceToken];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidRegisterForRemoteNotificationsEvent];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[BONCCore shareInstance].context.notificationsItem setUserInfo: userInfo];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidReceiveRemoteNotificationEvent];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[BONCCore shareInstance].context.notificationsItem setUserInfo: userInfo];
    [[BONCCore shareInstance].context.notificationsItem setNotificationResultHander: completionHandler];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidReceiveRemoteNotificationEvent];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[BONCCore shareInstance].context.notificationsItem setLocalNotification: notification];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidReceiveLocalNotificationEvent];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80000
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        [[BONCCore shareInstance].context.userActivityItem setUserActivity: userActivity];
        [[BONCModuleManager sharedManager] triggerEvent:BONCMDidUpdateUserActivityEvent];
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        [[BONCCore shareInstance].context.userActivityItem setUserActivityType: userActivityType];
        [[BONCCore shareInstance].context.userActivityItem setUserActivityError: error];
        [[BONCModuleManager sharedManager] triggerEvent:BONCMDidFailToContinueUserActivityEvent];
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        [[BONCCore shareInstance].context.userActivityItem setUserActivity: userActivity];
        [[BONCCore shareInstance].context.userActivityItem setRestorationHandler: restorationHandler];
        [[BONCModuleManager sharedManager] triggerEvent:BONCMContinueUserActivityEvent];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        [[BONCCore shareInstance].context.userActivityItem setUserActivityType: userActivityType];
        [[BONCModuleManager sharedManager] triggerEvent:BONCMWillContinueUserActivityEvent];
    }
    return YES;
}
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    [[BONCCore shareInstance].context.notificationsItem setNotification: notification];
    [[BONCCore shareInstance].context.notificationsItem setNotificationPresentationOptionsHandler: completionHandler];
    [[BONCCore shareInstance].context.notificationsItem setCenter:center];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMWillPresentNotificationEvent];
};

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    [[BONCCore shareInstance].context.notificationsItem setNotificationResponse: response];
    [[BONCCore shareInstance].context.notificationsItem setNotificationCompletionHandler:completionHandler];
    [[BONCCore shareInstance].context.notificationsItem setCenter:center];
    [[BONCModuleManager sharedManager] triggerEvent:BONCMDidReceiveNotificationResponseEvent];
};
#endif

@end

@implementation BONCOpenURLItem

@end

@implementation BONCShortcutItem

@end

@implementation BONCUserActivityItem

@end

@implementation BONCNotificationsItem

@end
