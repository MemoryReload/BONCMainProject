/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>
#import "BONCAppDelegate.h"

@class BONCConfig;

typedef enum
{
    BONCEnvironmentDev = 0,
    BONCEnvironmentTest,
    BONCEnvironmentStage,
    BONCEnvironmentProd
}BONCEnvironmentType;


@interface BONCContext : NSObject

//global env
@property(nonatomic, assign) BONCEnvironmentType env;

//global config
@property(nonatomic, strong) BONCConfig *config;

//application appkey
@property(nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property(nonatomic, assign) NSInteger customEvent;

@property(nonatomic, strong) UIApplication *application;

@property(nonatomic, strong) NSDictionary *launchOptions;

@property(nonatomic, strong) NSString *moduleConfigName;

@property(nonatomic, strong) NSString *serviceConfigName;

//3D-Touch model
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property (nonatomic, strong) BONCShortcutItem *touchShortcutItem;
#endif

//OpenURL model
@property (nonatomic, strong) BONCOpenURLItem *openURLItem;

//Notifications Remote or Local
@property (nonatomic, strong) BONCNotificationsItem *notificationsItem;

//user Activity Model
@property (nonatomic, strong) BONCUserActivityItem *userActivityItem;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end
