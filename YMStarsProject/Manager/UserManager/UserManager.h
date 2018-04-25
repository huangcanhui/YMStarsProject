//
//  UserManager.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "UserToken.h"

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);

#define isLogin [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]

/**
 * 包含用户相关
 */
@interface UserManager : NSObject
//单例
SINGLETON_FOR_HEADER(UserManager)

/**
 * 用户信息
 */
@property (nonatomic, strong)UserInfo *userinfo;
/**
 * 是否登录
 */
@property (nonatomic, assign)BOOL isLogined;
/**
 * 状态维护
 */
@property (nonatomic, strong)UserToken *token;
/**
 * 登录方式
 */
@property (nonatomic, assign)UserLoginType type;

#pragma mark -------- 登录相关 --------
/**
 * 第三方登录
 * @param loginType 登录方式
 * @param block 回调
 */
- (void)login:(UserLoginType)loginType completion:(loginBlock)block;
/**
 * 带参登录
 * @param loginType 登录方式
 * @param params 参数，手机和账号登录
 * @param block 回调
 */
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)block;
/**
 * 自动登录
 * @param block 回调
 */
- (void)autoLoginToServer:(loginBlock)block;
/**
 * 退出登录
 * @param block 回调
 */
- (void)logout:(loginBlock)block;
/**
 * 加载缓存用户数据
 * @return 是否成功
 */
- (BOOL)loadUserInfo;

@end
