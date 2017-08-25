//
//  BONCHTTPRequestServiceProtocol.h
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/9.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BONCCoreFramework/BONCCoreFramework.h>
#import <BONCNetworkFramework/BONCNetworkFileModel.h>

@protocol BONCHTTPRequestServiceProtocol <BONCServiceProtocol>
//发送get请求
-(NSURLSessionDataTask *_Nonnull)sendGETReqeustWithURL:(NSString*_Nonnull)urlStr parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
//发送post请求
-(NSURLSessionDataTask *_Nonnull)sendPOSTRequestWithURL:(NSString*_Nonnull)urlStr parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
