//
//  TLNetworkingHelper.m
//  CacheNetData-master
//
//  Created by iOS-Developer on 2017/9/12.
//  Copyright © 2017年 ShengShiQuanJing. All rights reserved.
//

#import "TLNetworkingHelper.h"
#import "TLNetworkCache.h"
#import <AFNetworking/AFNetworking.h>

@implementation TLNetworkingHelper

+ (void)downLoadWihtMethod:(RequestMethodType)methodType URL:(NSString *)urlString params:(id)params cache:(void (^)(id))cache success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 找到缓存
    if (cache) {
        id data = [TLNetworkCache httpCacheForURL:urlString parameters:params];
        
        cache(data);
    }
    
    // 获得manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置解析器 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 移除空Value
    [AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    
    // 申明请求的数据是Json类型   AFHTTPRequestSerializer AFJSONRequestSerializer
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 设置请求头
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //    NSString *url = [Base_URL stringByAppendingString:urlString];
    NSString *url = urlString;
    
    //    NSString *JsonParams = [ColorManager jsonStringWithDictionary:params];
    
    NSLog(@"*****************   start   *****************");
    NSLog(@"url: %@", url);
    NSLog(@"DictParams: %@", params);
    //    NSLog(@"JsonParams: %@", JsonParams);
    NSLog(@"******************   end   ******************");
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //            Get请求
            [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                if (failure) {
                    failure(error);
                    NSLog(@"error url: %@", url);
                    NSLog(@"error = %@", error);
                }
            }];
        }
            break;
            
        case RequestMethodTypePost:
        {
            // POST JSON传参
            
            /*
             *   发送JSON数据给服务器的步骤：
             *
             *   （1）一定要使用POST请求
             *
             *   （2）设置请求头
             *
             *   （3）设置JSON数据为请求体
             */
            [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:params error:nil];
            
            //            Post请求
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                if (success) {
                    // 请求成功的时候缓存
                    [TLNetworkCache setHttpCache:responseObject URL:urlString parameters:params];
                    
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                if (failure) {
                    failure(error);
                    NSLog(@"error url: %@", url);
                    NSLog(@"error = %@", error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
}


@end
