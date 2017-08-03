/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#ifndef BONCCommon_h
#define BONCCommon_h

// Debug Logging
#ifdef DEBUG
#define BONCLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define BONCLog(x, ...)
#endif

#endif /* BONCCommon_h */
