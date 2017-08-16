//
//  BONCHTTPRequestService.m
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "BONCHTTPRequestService.h"
#import <BONCCoreFramework/BONCCore.h>
#import <BONCNetworkFramework/AFHTTPSessionManager.h>
#import <BONCNetworkFramework/AFURLRequestSerialization.h>
#import <BONCNetworkFramework/AFURLResponseSerialization.h>
#import <BONCNetworkFramework/AFSecurityPolicy.h>

@implementation BONCHTTPRequestService

+(void)load{
    [[BONCCore shareInstance] registerService:@protocol(BONCHTTPRequestServiceProtocol) service:[self class]];
}

+ (BOOL)singleton
{
    return YES;
}


-(void)sendGETReqeustWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    AFHTTPSessionManager* manager=[[self class] sharedManager];
    [manager GET:urlStr parameters:params progress:downloadProgress success:success failure:failure];
}

-(void)sendPOSTRequestWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    AFHTTPSessionManager* manager=[[self class] sharedManager];
    //无文件上传的post请求
    if (!fileArray||fileArray.count==0) {
        [manager POST:urlStr parameters:params progress:uploadProgress success:success failure:failure];
        return;
    }
    //有文件上传的post请求
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (BONCNetworkFileModel* file in fileArray) {
            if (file.fileURL) {
                [formData appendPartWithFileURL:file.fileURL name:file.name fileName:file.fileName mimeType:file.mimeType error:nil];
            }
            else if (file.fileData){
                [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
            }
        }
    } progress:uploadProgress
    success:success failure:failure];
}

+(AFHTTPSessionManager *)sharedManager
{
    static AFHTTPSessionManager* manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPSessionManager manager];
        NSSet* contectSet=[NSSet setWithObjects:@"text/html", nil];
        NSArray* serializers=@[[AFJSONResponseSerializer serializer],[AFXMLParserResponseSerializer serializer],[AFPropertyListResponseSerializer serializer],[AFImageResponseSerializer serializer]];
        AFCompoundResponseSerializer* compoundResponseSerializer=[AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:serializers];
        compoundResponseSerializer.acceptableContentTypes=contectSet;
        manager.responseSerializer=compoundResponseSerializer;
    });
    return manager;
}
@end
