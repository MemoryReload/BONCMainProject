/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

@interface BONCAppDelegate : UIResponder <UIApplicationDelegate>

@end

typedef void (^BONCNotificationResultHandler)(UIBackgroundFetchResult);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
typedef void (^BONCNotificationPresentationOptionsHandler)(UNNotificationPresentationOptions options);
typedef void (^BONCNotificationCompletionHandler)();
#endif

@interface BONCNotificationsItem : NSObject
@property (nonatomic, strong) NSError *notificationsError;
@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, weak) BONCNotificationResultHandler notificationResultHander;
@property (nonatomic, strong) UILocalNotification *localNotification;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@property (nonatomic, strong) UNNotification *notification;
@property (nonatomic, strong) UNNotificationResponse *notificationResponse;
@property (nonatomic, weak) BONCNotificationPresentationOptionsHandler notificationPresentationOptionsHandler;
@property (nonatomic, weak) BONCNotificationCompletionHandler notificationCompletionHandler;
@property (nonatomic, strong) UNUserNotificationCenter *center;
#endif
@end

@interface BONCOpenURLItem : NSObject
@property (nonatomic, strong) NSURL *openURL;
@property (nonatomic, strong) NSString *sourceApplication;
@property (nonatomic, strong) NSDictionary *options;
@end

typedef void (^shortcutItemCompletionHandler)(BOOL);

@interface BONCShortcutItem : NSObject
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property(nonatomic, strong) UIApplicationShortcutItem *shortcutItem;
@property(nonatomic, copy) shortcutItemCompletionHandler scompletionHandler;
#endif
@end


typedef void (^restorationHandler)(NSArray *);

@interface BONCUserActivityItem : NSObject
@property (nonatomic, strong) NSString *userActivityType;
@property (nonatomic, strong) NSUserActivity *userActivity;
@property (nonatomic, strong) NSError *userActivityError;
@property (nonatomic, strong) restorationHandler restorationHandler;
@end

