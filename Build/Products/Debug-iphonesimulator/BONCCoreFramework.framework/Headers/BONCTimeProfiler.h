/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

extern const NSString *kTimeProfilerResultNotificationName;
extern const NSString *kNotificationUserInfoKey;

@interface BONCTimeProfiler : NSObject
+ (BONCTimeProfiler *)sharedTimeProfiler;
- (instancetype)initTimeProfilerWithMainKey:(NSString *)mainKey;
- (void)recordEventTime:(NSString *)eventName;
- (void)printOutTimeProfileResult;
- (void)saveTimeProfileDataIntoFile:(NSString *)filePath;
- (void)postTimeProfileResultNotification;
@end
