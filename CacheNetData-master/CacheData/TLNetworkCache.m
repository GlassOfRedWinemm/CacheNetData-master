//
//  TLNetworkCache.m
//  CacheNetData-master
//
//  Created by iOS-Developer on 2017/9/12.
//  Copyright © 2017年 ShengShiQuanJing. All rights reserved.
//

#import "TLNetworkCache.h"
#import <YYCache/YYCache.h>

static NSString *const NetWorkResponseCache = @"NetWorkResponseCache";

static YYCache *dataCache;

@implementation TLNetworkCache


+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCache = [YYCache cacheWithName:NetWorkResponseCache];
    });
}


+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize
{
    return [dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache
{
    [dataCache removeAllObjects];
}

#pragma mark -- 辅助方法
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}



@end
