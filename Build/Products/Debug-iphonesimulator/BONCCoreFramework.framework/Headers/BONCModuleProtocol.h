/**
 * Created by BeeHive.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>
#import "BONCAnnotation.h"

@class BONCContext;

#define BONC_EXPORT_MODULE(isAsync) \
+ (void)load { [BeeHive registerDynamicModule:[self class]]; } \
-(BOOL)async { return [[NSString stringWithUTF8String:#isAsync] boolValue];}


@protocol BONCModuleProtocol <NSObject>
@optional
//如果不去设置Level默认是Normal
//basicModuleLevel不去实现默认Normal
- (void)basicModuleLevel;
- (BOOL)async;
- (void)modSetUp:(BONCContext *)context;
- (void)modInit:(BONCContext *)context;
- (void)modSplash:(BONCContext *)context;
- (void)modQuickAction:(BONCContext *)context;
- (void)modTearDown:(BONCContext *)context;
- (void)modWillResignActive:(BONCContext *)context;
- (void)modDidEnterBackground:(BONCContext *)context;
- (void)modWillEnterForeground:(BONCContext *)context;
- (void)modDidBecomeActive:(BONCContext *)context;
- (void)modWillTerminate:(BONCContext *)context;
- (void)modUnmount:(BONCContext *)context;
- (void)modOpenURL:(BONCContext *)context;
- (void)modDidReceiveMemoryWaring:(BONCContext *)context;
- (void)modDidFailToRegisterForRemoteNotifications:(BONCContext *)context;
- (void)modDidRegisterForRemoteNotifications:(BONCContext *)context;
- (void)modDidReceiveRemoteNotification:(BONCContext *)context;
- (void)modDidReceiveLocalNotification:(BONCContext *)context;
- (void)modWillPresentNotification:(BONCContext *)context;
- (void)modDidReceiveNotificationResponse:(BONCContext *)context;
- (void)modWillContinueUserActivity:(BONCContext *)context;
- (void)modContinueUserActivity:(BONCContext *)context;
- (void)modDidFailToContinueUserActivity:(BONCContext *)context;
- (void)modDidUpdateContinueUserActivity:(BONCContext *)context;
- (void)modDidCustomEvent:(BONCContext *)context;
@end
