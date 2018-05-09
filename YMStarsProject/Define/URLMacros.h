//
//  URLMacros.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"https://www.ymstars.com/api"

#elif TestSever

/**测试服务器*/
#define URL_main @"https://www.ymstars.com/api"

#elif ProductSever

/**生产服务器*/
#define URL_main @"https://www.ymstars.com/api"
#endif


/**************************** 详细的接口地址 ****************************************/

#pragma mark ------------- 用户相关 -------------------
/**
 * 用户登录
 */
#define member_login_Url @"/v1/oauth/token"
/**
 * 刷新token
 */
#define member_refresh_token_Url @"/v1/oauth/token"
/**
 * 获取用户信息
 */
#define member_userinfo_Url @"/v1/social/current-user"

#pragma mark -------------------- 机构相关 -------------
/**
 * 获取用户所拥有的机构列表
 */
#define organ_List_Url @"/v1/social/current-user/all-organizations"
/**
 * 获取指定的机构信息
 */
#define organ_appoint_Url @"/v1/social/organizations"
/**
 * 获取机构开通的功能
 */
#define organ_function_Url @"/v1/social/social_types"
/**
 * 获取机构通讯录
 */
#define organ_TelList_Url @"/v1/social/organizations"

#pragma mark --------- 工具类 ---------
/**
 * 获取七牛token
 */
#define tool_qiniu_token_Url @"/v1/tool/qiniu-token"

#endif /* URLMacros_h */
