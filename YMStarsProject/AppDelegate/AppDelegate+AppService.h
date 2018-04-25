//
//  AppDelegate.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/**
 * 包含第三方 和应用内业务的实现，减轻入口代码压力
 */
@interface AppDelegate (AppService)
/**
 * 单例
 */
+ (AppDelegate *)shareAppDelegate;
/**
 * 初始化服务
 */
- (void)initService;
/**
 * 初始化widow
 */
- (void)initWindow;
/**
 * 初始化用户系统
 */
- (void)initUserManager;
/**
 * 监听网络状态
 */
- (void)monitorNetworkStatus;
/**
 * 初始化网络配置
 */
- (void)NetWorkConfig;
/**
 * 当前顶层控制器
 */
- (UIViewController *)getCurrentVC;

- (UIViewController *)getCurrentUIVC;

@end

