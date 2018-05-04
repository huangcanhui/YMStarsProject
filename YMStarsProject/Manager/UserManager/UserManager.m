//
//  UserManager.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "UserManager.h"
#import "CHTime.h"

//static float access_time = 21600; //accesstoken的有效时长
static float access_time = 60;
static float refresh_time = 604800; //refresh_token 的有效时长（以秒为单位, 7天） 7 * 24 * 3600

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
        [self loginToServer:dict path:member_login_Url completion:block];
    } else { //第三方的登录方式
        
    }
}

#pragma mark - 手动登录服务器
- (void)loginToServer:(NSDictionary *)params path:(NSString *)path completion:(loginBlock)block
{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];

    [[CHHTTPManager manager] requestWithMethod:POST WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary *responseObject) {
        self.token = [UserToken modelWithDictionary:responseObject[@"data"]];
        //存储token
        [self saveUserToken];
        //获取当前的时间
        [[CHTime getNowTimeTimestamp2] writeUserDefaultWithKey:@"currentTime"];
        self.isLogined = YES;
        [self loginSuccess:nil completion:block];
    } WithFailurBlock:^(NSError *error) {
         [MBProgressHUD hideHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [MBProgressHUD showErrorMessage:@"刷新token错误"];
            [self logout:nil];
            KPostNotification(KNotificationLoginStateChange, @NO);
        });
    }];
}

#pragma mark - 存储用户的token
- (void)saveUserToken
{
    if (self.token) {
        [self.token writeUserDefaultWithKey:KUserTokenCache];
    }
}

#pragma mark - 自动登录到服务器(即刷新token)
- (void)autoLoginToServer:(loginBlock)block
{
    NSString *curTime = [CHTime getNowTimeTimestamp2]; //获取当前的时间戳
    NSString *oldTime = [NSString readUserDefaultWithKey:@"currentTime"]; //token存储的时间
    if ([oldTime floatValue] + access_time <= [curTime floatValue]) { //即access_token过期
        if ([oldTime floatValue] + refresh_time <= [curTime floatValue]) { //即refresh_token已过期
            [self logout:nil];
        } else { //即refresh_token还未过期，刷新
            UserToken *token = [UserToken readUserDefaultWithKey:KUserTokenCache];
            NSDictionary *params = @{
                                     @"client_id":@3,
                                     @"client_secret":@"lynDaABD02gMPAD5jZWNTeSmG6jay3VoXzqklFOy",
                                     @"grant_type":@"refresh_token",
                                     @"refresh_token":token.refresh_token,
                                     };
            [self loginToServer:params path:member_refresh_token_Url completion:block];
        }
    }
}

#pragma mark - 登录成功处理
- (void)loginSuccess:(id)params completion:(loginBlock)block
{
    [[CHHTTPManager manager] requestWithMethod:GET WithPath:member_userinfo_Url WithParams:params WithSuccessBlock:^(NSDictionary *responseObject) {
        self.userinfo = [UserInfo modelWithDictionary:responseObject[@"data"]];
        [self saveUserInfo];
        [MBProgressHUD hideHUD];
        if (block) {
            block(YES, nil);
        }
        KPostNotification(KNotificationLoginStateChange, @YES);
    } WithFailurBlock:^(NSError *error) {
        
    }];
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

#pragma mark - 被踢下线
- (void)onKick
{
    [self logout:nil];
}

#pragma mark - 退出登录
- (void)logout:(loginBlock)block
{
    //移除掉小红点
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    self.userinfo = nil;
    self.isLogined = NO;
    [self.token removeUserDefaultWithKey:KUserTokenCache];
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
