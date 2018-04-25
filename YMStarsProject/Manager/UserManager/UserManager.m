//
//  UserManager.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

- (instancetype)init
{
    if (self = [super init]) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKick) name:KNotificationOnKick object:nil];
    }
    return self;
}

#pragma mark - 第三方登录
- (void)login:(UserLoginType)loginType completion:(loginBlock)block
{
    [self login:loginType params:nil completion:block];
}

#pragma mark - 带参数登录
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)block
{
    if (loginType == kUserLoginTypePwd) { //账号方式登录
        NSDictionary * dict = @{
                                 @"client_id":@3,
                                 @"client_secret":@"lynDaABD02gMPAD5jZWNTeSmG6jay3VoXzqklFOy",
                                 @"grant_type":@"password",
                                 @"username":[params objectForKey:@"userName"],
                                 @"password":[params objectForKey:@"password"]
                                 };
        [self loginToServer:dict completion:block];
    } else { //第三方的登录方式
        
    }
}

#pragma mark - 手动登录服务器
- (void)loginToServer:(NSDictionary *)params completion:(loginBlock)block
{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    //在这边进行网络数据的请求
}

#pragma mark - 自动登录到服务器
- (void)autoLoginToServer:(loginBlock)block
{
    
}

#pragma mark - 登录成功处理
- (void)loginSuccess:(id)responseObject completion:(loginBlock)block
{
    self.userinfo = [UserInfo modelWithDictionary:responseObject[@"data"]];
    [self saveUserInfo];
    self.isLogined = YES;
    if (block) {
        block(YES, nil);
    }
    KPostNotification(KNotificationLoginStateChange, @YES);
}

#pragma mark - 存储用户信息
- (void)saveUserInfo
{
    if (self.userinfo) {
        YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
        NSDictionary *dic = [self.userinfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
}

#pragma mark - 加载缓存的用户数据
- (BOOL)loadUserInfo
{
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    NSDictionary *userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.userinfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark - 退出登录
- (void)logout:(loginBlock)block
{
    //移除掉小红点
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    self.userinfo = nil;
    self.isLogined = NO;
    
    //移除缓存
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (block) {
            block(YES, nil);
        }
    }];
    KPostNotification(KNotificationLoginStateChange, @NO);
}

@end
