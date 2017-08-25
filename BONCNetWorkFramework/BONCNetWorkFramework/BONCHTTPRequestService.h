//
//  BONCHTTPRequestService.h
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BONCCoreFramework/BONCCore.h>
#import <BONCNetWorkFramework/BONCHTTPRequestServiceProtocol.h>
#import <BONCNetworkFramework/AFHTTPSessionManager.h>

/*BONCHTTPRequestServiceProtocol服务的实体服务类，此服务已经将自己注册为单例模式，建议使用者不要
 再重写+ (BOOL)singleton 修改服务的行为，全局使用一个sessionManager来管理HTTP请求。如果真的有特
 殊需要，可以直接使用AFHTTPSessionManager完成特殊配制的HTTP请求。
 */

@interface BONCHTTPRequestService : NSObject <BONCHTTPRequestServiceProtocol>

/*此方法将在服务init时调用，获得服务所使用的sessionManager。如果用户需要对session config进行个性
 化设置，可以继承这个服务类，重写此方法定制自己的session设置, 然后在项目中向core重新注册自己的服务类，
 core将会使用自定义的类作为网络请求服务。
 */
-(AFHTTPSessionManager*_Nonnull)sessionManager;

//发送get请求
-(NSURLSessionDataTask *_Nonnull)sendGETReqeustWithURL:(NSString*_Nonnull)urlStr parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

//发送post请求
-(NSURLSessionDataTask *_Nonnull)sendPOSTRequestWithURL:(NSString*_Nonnull)urlStr parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
