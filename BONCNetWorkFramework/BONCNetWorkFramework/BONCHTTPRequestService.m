//
//  BONCHTTPRequestService.m
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "BONCHTTPRequestService.h"
#import <BONCNetworkFramework/AFHTTPSessionManager.h>

@implementation BONCHTTPRequestService

@synthesize baseURL;
@synthesize configuration;
@synthesize requestSerializer;
@synthesize responseSerializer;
@synthesize securityPolicy;

-(void)sendGETReqeustWithURL:(NSURL*_Nullable)url parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    
}

-(void)sendPOSTRequestWithURL:(NSURL*_Nullable)url parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    
}

-(AFHTTPSessionManager*)getSessionManager
{
    return nil;
}
@end
