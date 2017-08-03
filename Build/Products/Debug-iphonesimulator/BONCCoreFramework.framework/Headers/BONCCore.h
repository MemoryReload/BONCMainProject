/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>
@class BONCContext;

@interface BONCCore : NSObject
//save application global context
@property(nonatomic, strong) BONCContext *context;
@property (nonatomic, assign) BOOL enableException;
+ (instancetype)shareInstance;
+ (void)registerDynamicModule:(Class) moduleClass;
- (id)createService:(Protocol *)proto;
//Registration is recommended to use a static way
- (void)registerService:(Protocol *)proto service:(Class) serviceClass;
+ (void)triggerCustomEvent:(NSInteger)eventType;
@end
