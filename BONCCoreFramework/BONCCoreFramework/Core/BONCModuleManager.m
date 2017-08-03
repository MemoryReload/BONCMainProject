/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "BONCModuleManager.h"
#import "BONCModuleProtocol.h"
#import "BONCContext.h"
#import "BONCTimeProfiler.h"

static const NSString *kModuleArrayKey = @"moduleClasses";
static const NSString *kModuleInfoNameKey = @"moduleClass";
static const NSString *kModuleInfoLevelKey = @"moduleLevel";

static  NSString *kSetupSelector = @"modSetUp:";
static  NSString *kInitSelector = @"modInit:";
static  NSString *kSplashSeletor = @"modSplash:";
static  NSString *kTearDownSelector = @"modTearDown:";
static  NSString *kWillResignActiveSelector = @"modWillResignActive:";
static  NSString *kDidEnterBackgroundSelector = @"modDidEnterBackground:";
static  NSString *kWillEnterForegroundSelector = @"modWillEnterForeground:";
static  NSString *kDidBecomeActiveSelector = @"modDidBecomeActive:";
static  NSString *kWillTerminateSelector = @"modWillTerminate:";
static  NSString *kUnmountEventSelector = @"modUnmount:";
static  NSString *kQuickActionSelector = @"modQuickAction:";
static  NSString *kOpenURLSelector = @"modOpenURL:";
static  NSString *kDidReceiveMemoryWarningSelector = @"modDidReceiveMemoryWaring:";
static  NSString *kFailToRegisterForRemoteNotificationsSelector = @"modDidFailToRegisterForRemoteNotifications:";
static  NSString *kDidRegisterForRemoteNotificationsSelector = @"modDidRegisterForRemoteNotifications:";
static  NSString *kDidReceiveRemoteNotificationsSelector = @"modDidReceiveRemoteNotification:";
static  NSString *kDidReceiveLocalNotificationsSelector = @"modDidReceiveLocalNotification:";
static  NSString *kWillPresentNotificationSelector = @"modWillPresentNotification:";
static  NSString *kDidReceiveNotificationResponseSelector = @"modDidReceiveNotificationResponse:";
static  NSString *kWillContinueUserActivitySelector = @"modWillContinueUserActivity:";
static  NSString *kContinueUserActivitySelector = @"modContinueUserActivity:";
static  NSString *kDidUpdateContinueUserActivitySelector = @"modDidUpdateContinueUserActivity:";
static  NSString *kFailToContinueUserActivitySelector = @"modDidFailToContinueUserActivity:";
static  NSString *kAppCustomSelector = @"modDidCustomEvent:";



@interface BONCModuleManager()

@property(nonatomic, strong) NSMutableArray     *BONCModuleDynamicClasses;

@property(nonatomic, strong)  NSMutableArray      *BONCModules;

@end

@implementation BONCModuleManager

#pragma mark - public

+ (instancetype)sharedManager
{
    static id sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BONCModuleManager alloc] init];
    });
    return sharedManager;
}

- (void)loadLocalModules
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:[BONCContext shareInstance].moduleConfigName ofType:@"plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        return;
    }
    
    NSDictionary *moduleList = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *modulesArray = [moduleList objectForKey:kModuleArrayKey];
    
    [self.BONCModules addObjectsFromArray:modulesArray];
    
}

- (void)registerDynamicModule:(Class)moduleClass
{
    [self addModuleFromObject:moduleClass];
 
}

- (void)registedAllModules
{

    [self.BONCModules sortUsingComparator:^NSComparisonResult(NSDictionary *module1, NSDictionary *module2) {
      NSNumber *module1Level = (NSNumber *)[module1 objectForKey:kModuleInfoLevelKey];
      NSNumber *module2Level =  (NSNumber *)[module2 objectForKey:kModuleInfoLevelKey];
        
        return [module1Level intValue] > [module2Level intValue];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    //module init
    [self.BONCModules enumerateObjectsUsingBlock:^(NSDictionary *module, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *classStr = [module objectForKey:kModuleInfoNameKey];
        
        Class moduleClass = NSClassFromString(classStr);
        
        if (NSStringFromClass(moduleClass)) {
            id<BONCModuleProtocol> moduleInstance = [[moduleClass alloc] init];
            [tmpArray addObject:moduleInstance];
        }
        
    }];
    
    [self.BONCModules removeAllObjects];

    [self.BONCModules addObjectsFromArray:tmpArray];
    
}

- (void)triggerEvent:(BONCModuleEventType)eventType
{
    switch (eventType) {
        case BONCMSetupEvent:
            [self handleModuleEvent:kSetupSelector];
            break;
        case BONCMInitEvent:
            //special
            [self handleModulesInitEvent];
            break;
        case BONCMTearDownEvent:
            //special
            [self handleModulesTearDownEvent];
            break;
        case BONCMSplashEvent:
            [self handleModuleEvent:kSplashSeletor];
            break;
        case BONCMWillResignActiveEvent:
            [self handleModuleEvent:kWillResignActiveSelector];
            break;
        case BONCMDidEnterBackgroundEvent:
            [self handleModuleEvent:kDidEnterBackgroundSelector];
            break;
        case BONCMWillEnterForegroundEvent:
            [self handleModuleEvent:kWillEnterForegroundSelector];
            break;
        case BONCMDidBecomeActiveEvent:
            [self handleModuleEvent:kDidBecomeActiveSelector];
            break;
        case BONCMWillTerminateEvent:
            [self handleModuleEvent:kWillTerminateSelector];
            break;
        case BONCMUnmountEvent:
            [self handleModuleEvent:kUnmountEventSelector];
            break;
        case BONCMOpenURLEvent:
            [self handleModuleEvent:kOpenURLSelector];
            break;
        case BONCMDidReceiveMemoryWarningEvent:
            [self handleModuleEvent:kDidReceiveMemoryWarningSelector];
            break;
            
        case BONCMDidReceiveRemoteNotificationEvent:
            [self handleModuleEvent:kDidReceiveRemoteNotificationsSelector];
            break;
        case BONCMWillPresentNotificationEvent:
            [self handleModuleEvent:kWillPresentNotificationSelector];
            break;
        case BONCMDidReceiveNotificationResponseEvent:
            [self handleModuleEvent:kDidReceiveNotificationResponseSelector];
            break;

        case BONCMDidFailToRegisterForRemoteNotificationsEvent:
            [self handleModuleEvent:kFailToRegisterForRemoteNotificationsSelector];
            break;
        case BONCMDidRegisterForRemoteNotificationsEvent:
            [self handleModuleEvent:kDidRegisterForRemoteNotificationsSelector];
            break;
            
        case BONCMDidReceiveLocalNotificationEvent:
            [self handleModuleEvent:kDidReceiveLocalNotificationsSelector];
            break;
            
        case BONCMWillContinueUserActivityEvent:
            [self handleModuleEvent:kWillContinueUserActivitySelector];
            break;
            
        case BONCMContinueUserActivityEvent:
            [self handleModuleEvent:kContinueUserActivitySelector];
            break;
            
        case BONCMDidFailToContinueUserActivityEvent:
            [self handleModuleEvent:kFailToContinueUserActivitySelector];
            break;
            
        case BONCMDidUpdateUserActivityEvent:
            [self handleModuleEvent:kDidUpdateContinueUserActivitySelector];
            break;
            
        case BONCMQuickActionEvent:
            [self handleModuleEvent:kQuickActionSelector];
            break;
            
        default:
            [BONCContext shareInstance].customEvent = eventType;
            [self handleModuleEvent:kAppCustomSelector];
            break;
    }
}


#pragma mark - life loop

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.BONCModuleDynamicClasses = [NSMutableArray array];
    }
    return self;
}


#pragma mark - private

- (BONCModuleLevel)checkModuleLevel:(NSUInteger)level
{
    switch (level) {
        case 0:
            return BONCModuleBasic;
            break;
        case 1:
            return BONCModuleNormal;
            break;
        default:
            break;
    }
    //default normal
    return BONCModuleNormal;
}


- (void)addModuleFromObject:(id)object
{
    Class class;
    NSString *moduleName = nil;
    
    if (object) {
        class = object;
        moduleName = NSStringFromClass(class);
    } else {
        return ;
    }
    
    if ([class conformsToProtocol:@protocol(BONCModuleProtocol)]) {
        NSMutableDictionary *moduleInfo = [NSMutableDictionary dictionary];
        
        BOOL responseBasicLevel = [class instancesRespondToSelector:@selector(basicModuleLevel)];

        int levelInt = 1;
        
        if (responseBasicLevel) {
            levelInt = 0;
        }
        
        [moduleInfo setObject:@(levelInt) forKey:kModuleInfoLevelKey];
        if (moduleName) {
            [moduleInfo setObject:moduleName forKey:kModuleInfoNameKey];
        }

        [self.BONCModules addObject:moduleInfo];
    }
}

#pragma mark - property setter or getter

- (NSMutableArray *)BONCModules
{
    if (!_BONCModules) {
        _BONCModules = [NSMutableArray array];
    }
    return _BONCModules;
}

#pragma mark - module protocol

- (void)handleModulesInitEvent
{
    
    [self.BONCModules enumerateObjectsUsingBlock:^(id<BONCModuleProtocol> moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(&*self) wself = self;
        void ( ^ bk )();
        bk = ^(){
            __strong typeof(&*self) sself = wself;
            if (sself) {
                if ([moduleInstance respondsToSelector:@selector(modInit:)]) {
                    [moduleInstance modInit:[BONCContext shareInstance]];
                }
            }
        };

        [[BONCTimeProfiler sharedTimeProfiler] recordEventTime:[NSString stringWithFormat:@"%@ --- modInit:", [moduleInstance class]]];
        
        if ([moduleInstance respondsToSelector:@selector(async)]) {
            BOOL async = [moduleInstance async];
            
            if (async) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    bk();
                });
                
            } else {
                bk();
            }
        } else {
            bk();
        }
    }];
}

- (void)handleModulesTearDownEvent
{
    //Reverse Order to unload
    for (int i = (int)self.BONCModules.count - 1; i >= 0; i--) {
        id<BONCModuleProtocol> moduleInstance = [self.BONCModules objectAtIndex:i];
        if (moduleInstance && [moduleInstance respondsToSelector:@selector(modTearDown:)]) {
            [moduleInstance modTearDown:[BONCContext shareInstance]];
        }
    }
}

- (void)handleModuleEvent:(NSString *)selectorStr
{
    SEL seletor = NSSelectorFromString(selectorStr);
    [self.BONCModules enumerateObjectsUsingBlock:^(id<BONCModuleProtocol> moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([moduleInstance respondsToSelector:seletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [moduleInstance performSelector:seletor withObject:[BONCContext shareInstance]];
#pragma clang diagnostic pop

        [[BONCTimeProfiler sharedTimeProfiler] recordEventTime:[NSString stringWithFormat:@"%@ --- %@", [moduleInstance class], NSStringFromSelector(seletor)]];

        }
    }];
}

@end

