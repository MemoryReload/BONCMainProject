/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>
#import "BONCAnnotation.h"

@protocol BONCServiceProtocol <NSObject>
@optional
+ (BOOL)singleton;
+ (id)shareInstance;
@end