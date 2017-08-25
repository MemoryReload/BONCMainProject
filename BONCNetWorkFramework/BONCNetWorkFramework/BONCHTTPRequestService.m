//
//  BONCHTTPRequestService.m
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "BONCHTTPRequestService.h"
#import <BONCNetworkFramework/AFHTTPSessionManager.h>
#import <BONCNetworkFramework/AFURLRequestSerialization.h>
#import <BONCNetworkFramework/AFURLResponseSerialization.h>
#import <BONCNetworkFramework/AFSecurityPolicy.h>

@interface BONCHTTPRequestService ()
@property (nonatomic,strong) AFHTTPSessionManager* manager;
@end

@implementation BONCHTTPRequestService

+(void)load{
    [[BONCCore shareInstance] registerService:@protocol(BONCHTTPRequestServiceProtocol) service:[self class]];
}

+ (BOOL)singleton
{
    return YES;
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        _manager=[self sessionManager];
        if (!_manager) {
            [NSException raise:NSInvalidArgumentException format:@"the session mananger of BONCHTTPRequestService couldn't be nill."];
        }
    }
    return self;
}



-(AFHTTPSessionManager*_Nonnull)sessionManager
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    NSSet* contectSet=[NSSet setWithObjects:@"text/html", nil];
    NSArray* serializers=@[[AFJSONResponseSerializer serializer],[AFXMLParserResponseSerializer serializer],[AFPropertyListResponseSerializer serializer],[AFImageResponseSerializer serializer]];
    AFCompoundResponseSerializer* compoundResponseSerializer=[AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:serializers];
    compoundResponseSerializer.acceptableContentTypes=contectSet;
    manager.responseSerializer=compoundResponseSerializer;
    return manager;
}

-(NSURLSessionDataTask *_Nonnull)sendGETReqeustWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    return [self.manager GET:urlStr parameters:params progress:downloadProgress success:success failure:failure];
}

-(NSURLSessionDataTask *_Nonnull)sendPOSTRequestWithURL:(NSString*)urlStr parameters:(NSDictionary*_Nullable)params files:(NSArray<BONCNetworkFileModel*>*_Nullable)fileArray progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    //无文件上传的post请求
    if (!fileArray||fileArray.count==0) {
        return [self.manager POST:urlStr parameters:params progress:uploadProgress success:success failure:failure];
    }
    //有文件上传的post请求
    return [self.manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
@end
