//
//  BONCNetworkFileModel.m
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/15.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "BONCNetworkFileModel.h"

@interface BONCNetworkFileModel ()
@property (nonatomic,readwrite) NSURL* fileURL;
@property (nonatomic,readwrite) NSData* fileData;
@property (nonatomic,readwrite) NSString* name;
@property (nonatomic,readwrite) NSString* fileName;
@property (nonatomic,readwrite) NSString* mimeType;
@end

@implementation BONCNetworkFileModel
-(instancetype)initWithFileURL:(NSURL *)fileURL name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType
{
    self=[super init];
    if (self) {
        _fileURL=fileURL;
        _name=name;
        _fileName=fileName;
        _mimeType=mimeType;
    }
    return self;
}

-(instancetype)initWithFileData:(NSData *)data
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType
{
    self=[super init];
    if (self) {
        _fileData=data;
        _name=name;
        _fileName=fileName;
        _mimeType=mimeType;
    }
    return self;
}
@end
