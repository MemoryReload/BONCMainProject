/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "BONCContext.h"
#import "BONCServiceProtocol.h"
#import "BONCConfig.h"

@interface BONCContext()

@property(nonatomic, strong) NSMutableDictionary *modulesByName;

@property(nonatomic, strong) NSMutableDictionary *servicesByName;

@end

@implementation BONCContext

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id BONCInstance = nil;
    
    dispatch_once(&p, ^{
        BONCInstance = [[[self class] alloc] init];
        if ([BONCInstance isKindOfClass:[BONCContext class]]) {
            ((BONCContext *) BONCInstance).config = [BONCConfig shareInstance];
        }
    });
    
    return BONCInstance;
}

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName
{
    [[BONCContext shareInstance].servicesByName setObject:implInstance forKey:serviceName];
}

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName
{
    return [[BONCContext shareInstance].servicesByName objectForKey:serviceName];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modulesByName  = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.servicesByName  = [[NSMutableDictionary alloc] initWithCapacity:1];
//        self.moduleConfigName = @"BONCCore.bundle/BONCCore";
//        self.serviceConfigName = @"BONCCore.bundle/BONCService";
      
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
        self.touchShortcutItem = [BONCShortcutItem new];
#endif

        self.openURLItem = [BONCOpenURLItem new];
        self.notificationsItem = [BONCNotificationsItem new];
        self.userActivityItem = [BONCUserActivityItem new];
    }

    return self;
}

@end
