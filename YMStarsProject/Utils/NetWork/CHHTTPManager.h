//
//  CHHTTPManager.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**
 * 这是一个网络状态的枚举
 */
typedef NS_ENUM(NSUInteger, CHNetWorkStatusType)
{
    CHNetWorkStatusUnkonwn, //未知网络
    CHNetWorkStatusReachable, //无网络
    CHNetWorkStatusReachableViaWWAN, //手机网络
    CHNetWorkStatusReachableViaWiFi //WiFi
};

/**
 * 这是一个请求方式的枚举
 */
typedef NS_ENUM(NSUInteger, HTTPMethod)
{
    GET,
    POST,
    DELETE,
    PUT,
    HEAD,
    PATCH
};

/**
 * 网络状态的block
 */
typedef void(^CHNetworkStatus) (CHNetWorkStatusType status);

/**
 * 请求成功回调block
 */
typedef void (^requestSuccessBlock)(NSDictionary *responseObject);

/**
 * 请求失败回调block
 */
typedef void (^requestFailureBlock)(NSError *error);

@interface CHHTTPManager : AFHTTPSessionManager

/**
 * 实时获取网络状态，通过block回调实时获取
 */
+ (void)networkStatusWithBlock:(CHNetworkStatus)networkStatus;

/**
 * 单例
 */
+ (instancetype)manager;

/*
 * 网络请求方式
 * @param method 为请求方式get、post等
 * @param path 后台获取的网络接口
 * @param params传递给后台的参数
 * @param success 请求回调成功的block
 * @param failure 请求失败回调的block
 **/
- (void)requestWithMethod:(HTTPMethod)method WithPath:(NSString *)path WithParams:(NSDictionary*)params WithSuccessBlock:(requestSuccessBlock)success WithFailurBlock:(requestFailureBlock)failure;
@end
