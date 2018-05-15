//
//  IMManager.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/15.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "IMManager.h"
#import <RongIMKit/RongIMKit.h>
#import "CHHTTPManager.h"
#import "RCDRCIMDataSource.h"

@implementation IMManager

SINGLETON_FOR_CLASS(IMManager);

#pragma mark - 初始化IM
- (void)initIM
{
    //注册APPKey
    [[RCIM sharedRCIM] initWithAppKey:RCloudKey];
    //用户的头像
    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启用户信息持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    //数据源
//    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
}

- (void)loginIMCompletion:(loginBlock)completion
{
    [[CHHTTPManager manager] requestWithMethod:GET WithPath:tool_RCloud_token_Url WithParams:nil WithSuccessBlock:^(NSDictionary *responseObject) {
        //连接融云服务器
        [[RCIM sharedRCIM]connectWithToken:responseObject[@"data"][@"token"] success:^(NSString *userId) {
            if (completion) {
                completion(YES, [NSString stringWithFormat:@"登录成功UserId:%@", userId]);
            }
        } error:^(RCConnectErrorCode status) {
            if (completion) {
                completion(NO, [NSString stringWithFormat:@"错误码为%ld", (long)status]);
            }
        } tokenIncorrect:^{
            if (completion) {
                completion(NO, @"token错误");
            }
        }];
    } WithFailurBlock:^(NSError *error) {
        
    }];
}

- (void)loginOutIM
{
    //断开与融云的连接
    [[RCIM sharedRCIM] disconnect];
}

@end
