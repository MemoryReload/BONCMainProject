//
//  BONCNetworkFileModel.h
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import <Foundation/Foundation.h>

//对form表单文件对象的抽象
@interface BONCNetworkFileModel : NSObject
//form表单文件所在路径的URL表示
@property (nonatomic,readonly) NSURL* fileURL;
//form表单文件数据
@property (nonatomic,readonly) NSData* fileData;
//form表单文件的索引文件名(key)
@property (nonatomic,readonly) NSString* name;
//form表单文件的真实文件名
@property (nonatomic,readonly) NSString* fileName;
//form表单文件的MIME
@property (nonatomic,readonly) NSString* mimeType;
-(instancetype)init __attribute__((unavailable("init not available, call designated init method instead")));
//以文件路径的形式初始化文件模型
-(instancetype)initWithFileURL:(NSURL *)fileURL name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
//以内存数据的形式初始化文件模型（第一种方式是被推荐的，低内存消耗）
-(instancetype)initWithFileData:(NSData *)data
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType;
@end
