//
//  AppDelegate.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "CHLoginViewController.h"

@implementation AppDelegate(AppService)

#pragma mark - 初始化服务
+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)initService
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:KNotificationNetWorkStateChange object:nil];
}

#pragma mark - 初始化window
- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark - 登录状态处理
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) { //登录成功加载主窗口控制器
        //为避免自动登录成功刷新tabbar
        if (!self.mainTabbar || ![self.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
            self.mainTabbar = [MainTabBarController new];
            CATransition *anima = [CATransition animation];
            anima.type = @"cube"; //设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            self.window.rootViewController = self.mainTabbar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        }
    } else { //登录失败，加载登录页面控制器
        self.mainTabbar = nil;
        CHNavigationController *loginNavi = [[CHNavigationController alloc] initWithRootViewController:[CHLoginViewController new]];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"fade";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = loginNavi;
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}

#pragma mark - 网络状态变化
- (void)netWorkStateChange:(NSNotification *)notification
{
    
}

#pragma mark - 网络状态监听
- (void)monitorNetworkStatus
{
    
}

@end
