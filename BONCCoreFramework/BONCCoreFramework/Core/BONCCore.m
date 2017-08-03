/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "BONCCore.h"
#import "BONCModuleProtocol.h"
#import "BONCContext.h"
#import "BONCAppDelegate.h"
#import "BONCModuleManager.h"
#import "BONCServiceManager.h"

@implementation BONCCore

#pragma mark - public

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id BONCInstance = nil;
    
    dispatch_once(&p, ^{
        BONCInstance = [[self alloc] init];
    });
    
    return BONCInstance;
}

+ (void)registerDynamicModule:(Class)moduleClass
{
    [[BONCModuleManager sharedManager] registerDynamicModule:moduleClass];
}

- (id)createService:(Protocol *)proto;
{
    return [[BONCServiceManager sharedManager] createService:proto];
}

- (void)registerService:(Protocol *)proto service:(Class) serviceClass
{
    [[BONCServiceManager sharedManager] registerService:proto implClass:serviceClass];
}
    
+ (void)triggerCustomEvent:(NSInteger)eventType
{
    if(eventType < 1000) {
        return;
    }
    
    [[BONCModuleManager sharedManager] triggerEvent:eventType];
}

#pragma mark - Private

-(void)setContext:(BONCContext *)context
{
    _context = context;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadStaticServices];
        [self loadStaticModules];
    });
}


- (void)loadStaticModules
{
    
    [[BONCModuleManager sharedManager] loadLocalModules];
    
    [[BONCModuleManager sharedManager] registedAllModules];
    
}

-(void)loadStaticServices
{
    [BONCServiceManager sharedManager].enableException = self.enableException;
    
    [[BONCServiceManager sharedManager] registerLocalServices];
    
}

@end
