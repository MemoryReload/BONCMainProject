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
-(void)sendGETReqeustWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

-(void)sendPOSTRequestWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
