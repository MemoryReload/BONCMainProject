//
//  AppDelegate.m
//  Example
//
//  Created by Heping on 2017/8/3.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewServiceProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BONCContext shareInstance].application = application;
    [BONCContext shareInstance].launchOptions = launchOptions;
    [BONCContext shareInstance].moduleConfigName = @"moduleList";//可选，默认为BONCCore.bundle/BONCCore.plist
    [BONCContext shareInstance].serviceConfigName = @"serviceList";
    
    [BONCCore shareInstance].enableException = YES;
    [[BONCCore shareInstance] setContext:[BONCContext shareInstance]];
    [[BONCTimeProfiler sharedTimeProfiler] recordEventTime:@"BONCCore::super start launch"];
    // Override point for customization after application launch.
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    id<ViewServiceProtocol> testVC=[[BONCCore shareInstance] createService:@protocol(ViewServiceProtocol)];
    self.window.rootViewController=(UIViewController*)testVC;
    [self.window makeKeyAndVisible];
    [testVC changeBackGroundWithColor:[UIColor redColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    return YES;
}

-(void)testNotification:(NSNotification*)notification
{
    NSLog(@"networkStatus is %@",AFStringFromNetworkReachabilityStatus([[[notification userInfo] valueForKey:AFNetworkingReachabilityNotificationStatusItem] integerValue]));
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
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


@end
