//
//  BONCHTTPRequestServiceProtocol.h
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/9.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BONCNetworkFramework/BONCNetworkFileModel.h>
#import <BONCNetworkFramework/AFURLRequestSerialization.h>
#import <BONCNetworkFramework/AFURLResponseSerialization.h>
#import <BONCNetworkFramework/AFSecurityPolicy.h>

@protocol BONCHTTPRequestServiceProtocol <NSObject>

@property (nonatomic, strong) NSURL * _Nullable baseURL;
@property (nonatomic, strong) NSURLSessionConfiguration * _Nullable configuration;
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * _Nullable responseSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * _Nullable requestSerializer;
@property (nonatomic, strong) AFSecurityPolicy * _Nullable securityPolicy;

-(NSURLSessionDataTask *_Nullable)sendGETReqeustWithURL:(NSURL*_Nullable)url parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

-(NSURLSessionDataTask *_Nullable)sendPOSTRequestWithURL:(NSURL*_Nullable)url parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                        success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
