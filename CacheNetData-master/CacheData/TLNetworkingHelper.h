//
//  TLNetworkingHelper.h
//  CacheNetData-master
//
//  Created by iOS-Developer on 2017/9/12.
//  Copyright © 2017年 ShengShiQuanJing. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM (NSInteger, RequestMethodType) {
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

@interface TLNetworkingHelper : NSObject

/**
 *   请求数据       带缓存
 *
 *   @param methodType 请求类型 Post and Get
 *   @param urlString 请求链接
 *   @param params    请求参数
 *   @param cache     Cache
 *   @param success   请求成功
 *   @param failure   请求失败
 */
+ (void)downLoadWihtMethod  :(RequestMethodType)methodType
        URL                 :(NSString *)urlString
        params              :(id)params
        cache               :(void (^)(id cache))cache
        success             :(void (^)(id response))success
        failure             :(void (^)(NSError *error))failure;

@end
