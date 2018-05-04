//
//  Commonmacros.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

//全局标记字符串，用于通知和存储

#ifndef Commonmacros_h
#define Commonmacros_h

#pragma mark - 用户相关
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

//用户的token名称
#define KUserToken @"KUserToken"

//用户token缓存
#define KUserTokenCache @"KUserTokenCache"

#pragma mark - 机构相关
//机构的ID
#define KOrganizationID @"KOrganizationID"

//机构名称
#define KOrganizationName @"KOrganizationName"

#pragma mark - 网络状态相关
//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#endif /* Commonmacros_h */
