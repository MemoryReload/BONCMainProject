//
//  BONCNetworkStatusModule.m
//  BONCNetWorkFramework
//
//  Created by Heping on 2017/8/8.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "BONCNetworkDetectModule.h"
#import "AFNetworkReachabilityManager.h"

@interface BONCNetworkDetectModule ()
{
    AFNetworkReachabilityManager* _manager;
}
@end

@implementation BONCNetworkDetectModule
BONC_EXPORT_MODULE(YES)

- (void)modSetUp:(BONCContext *)context
{
    if (!_manager) {
        _manager=[AFNetworkReachabilityManager sharedManager];
    }
}

- (void)modInit:(BONCContext *)context
{
    [_manager startMonitoring];
}

- (void)modTearDown:(BONCContext *)context
{
    [_manager stopMonitoring];
    _manager=nil;
}

@end
