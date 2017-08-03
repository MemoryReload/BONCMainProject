/**
 * Created by BONCCore.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "BONCConfig.h"
#import "BONCCommon.h"

@interface BONCConfig()

@property(nonatomic, strong) NSMutableDictionary *config;

@end

@implementation BONCConfig

static BONCConfig *_BONCConfigInstance;


+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    
    dispatch_once(&p, ^{
        _BONCConfigInstance = [[[self class] alloc] init];
    });
    return _BONCConfigInstance;
}


+ (NSString *)stringValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return nil;
    }
    
    return (NSString *)[[BONCConfig shareInstance].config objectForKey:key];
}

+ (NSDictionary *)dictionaryValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return nil;
    }
    
    if (![[[BONCConfig shareInstance].config objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return (NSDictionary *)[[BONCConfig shareInstance].config objectForKey:key];
}

+ (NSArray *)arrayValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return nil;
    }
    
    if (![[[BONCConfig shareInstance].config objectForKey:key] isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return (NSArray *)[[BONCConfig shareInstance].config objectForKey:key];
}

+ (NSInteger)integerValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return 0;
    }
    
    return [[[BONCConfig shareInstance].config objectForKey:key] integerValue];
}

+ (float)floatValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return 0.0;
    }
    
    return [(NSNumber *)[[BONCConfig shareInstance].config objectForKey:key] floatValue];
}

+ (BOOL)boolValue:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return NO;
    }
    
    return [(NSNumber *)[[BONCConfig shareInstance].config objectForKey:key] boolValue];
}


+ (id)get:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        @throw [NSException exceptionWithName:@"ConfigNotInitialize" reason:@"config not initialize" userInfo:nil];
        
        return nil;
    }
    
    id v = [[BONCConfig shareInstance].config objectForKey:key];
    if (!v) {
        BONCLog(@"InvaildKeyValue %@ is nil", key);
    }
    
    return v;
}

+ (BOOL)has:(NSString *)key
{
    if (![BONCConfig shareInstance].config) {
        return NO;
    }
    
    if (![[BONCConfig shareInstance].config objectForKey:key]) {
        return NO;
    }
    
    return YES;
}

+ (void)set:(NSString *)key value:(id)value
{
    if (![BONCConfig shareInstance].config) {
        [BONCConfig shareInstance].config = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    [[BONCConfig shareInstance].config setObject:value forKey:key];
}


+ (void)set:(NSString *)key boolValue:(BOOL)value
{
    [self set:key value:[NSNumber numberWithBool:value]];
}

+ (void)set:(NSString *)key integerValue:(NSInteger)value
{
    [self set:key value:[NSNumber numberWithInteger:value]];
}


+ (void) add:(NSDictionary *)parameters
{
    if (![BONCConfig shareInstance].config) {
        [BONCConfig shareInstance].config = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    [[BONCConfig shareInstance].config addEntriesFromDictionary:parameters];
}

+ (NSDictionary *) getAll
{
    return [BONCConfig shareInstance].config;
}

+ (void)clear
{
    if ([BONCConfig shareInstance].config) {
        [[BONCConfig shareInstance].config removeAllObjects];
    }
}

@end
