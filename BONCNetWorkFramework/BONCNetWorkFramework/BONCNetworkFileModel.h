//
//  BONCNetworkFileModel.h
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BONCNetworkFileModel : NSObject
@property (nonatomic,readonly) NSURL* fileURL;
@property (nonatomic,readonly) NSData* fileData;
@property (nonatomic,readonly) NSString* name;
@property (nonatomic,readonly) NSString* fileName;
@property (nonatomic,readonly) NSString* mimeType;
-(instancetype)initWithFileURL:(NSURL *)fileURL name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
-(instancetype)initWithFileData:(NSData *)data
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType;
@end
