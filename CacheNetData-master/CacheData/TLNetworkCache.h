//
//  TLNetworkCache.h
//  CacheNetData-master
//
//  Created by iOS-Developer on 2017/9/12.
//  Copyright © 2017年 ShengShiQuanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNetworkCache : NSObject


/**
 *  异步缓存网络数据,根据请求的URL和param
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  取出缓存数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 *  清空所有网络缓存
 */
+ (void)removeAllHttpCache;


@end
