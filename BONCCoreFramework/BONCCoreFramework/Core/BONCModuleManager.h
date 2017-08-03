/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BONCModuleLevel)
{
    BONCModuleBasic  = 0,
    BONCModuleNormal = 1
};

typedef NS_ENUM(NSInteger, BONCModuleEventType)
{
    BONCMSetupEvent = 0,
    BONCMInitEvent,
    BONCMTearDownEvent,
    BONCMSplashEvent,
    BONCMQuickActionEvent,
    BONCMWillResignActiveEvent,
    BONCMDidEnterBackgroundEvent,
    BONCMWillEnterForegroundEvent,
    BONCMDidBecomeActiveEvent,
    BONCMWillTerminateEvent,
    BONCMUnmountEvent,
    BONCMOpenURLEvent,
    BONCMDidReceiveMemoryWarningEvent,
    BONCMDidFailToRegisterForRemoteNotificationsEvent,
    BONCMDidRegisterForRemoteNotificationsEvent,
    BONCMDidReceiveRemoteNotificationEvent,
    BONCMDidReceiveLocalNotificationEvent,
    BONCMWillPresentNotificationEvent,
    BONCMDidReceiveNotificationResponseEvent,
    BONCMWillContinueUserActivityEvent,
    BONCMContinueUserActivityEvent,
    BONCMDidFailToContinueUserActivityEvent,
    BONCMDidUpdateUserActivityEvent,
    BONCMDidCustomEvent = 1000
    
};


@class BONCModule;

@interface BONCModuleManager : NSObject
+ (instancetype)sharedManager;
// If you do not comply with set Level protocol, the default Normal
- (void)registerDynamicModule:(Class)moduleClass;
- (void)loadLocalModules;
- (void)registedAllModules;
- (void)triggerEvent:(BONCModuleEventType)eventType;
@end

