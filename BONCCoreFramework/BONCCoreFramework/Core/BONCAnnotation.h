/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */


#import <Foundation/Foundation.h>

#ifndef BONCcoreModSectName
#define BONCcoreModSectName "BONCcoreMods"
#endif

#ifndef BONCcoreServiceSectName
#define BONCcoreServiceSectName "BONCcoreServices"
#endif

#define BONCCoreDATA(sectname) __attribute((used, section("__DATA,"#sectname" ")))
#define BONCCoreMod(name) \
class BONCCore; char * k##name##_mod BONCCoreDATA(BONCcoreMods) = ""#name"";
#define BONCCoreService(servicename,impl) \
class BONCCore;char * k##servicename##_service BONCCoreDATA(BONCcoreServices) = "{ \""#servicename"\" : \""#impl"\"}";

@interface BONCAnnotation : NSObject

@end
