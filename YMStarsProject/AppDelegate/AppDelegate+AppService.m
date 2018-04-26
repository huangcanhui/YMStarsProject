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
    //登录状态监听
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

#pragma mark - 初始化用户系统
- (void)initUserManager
{
    if ([userManager loadUserInfo]) { //有缓存的用户数据
        self.mainTabbar = [MainTabBarController new];
        self.window.rootViewController = self.mainTabbar;
        [userManager autoLoginToServer:^(BOOL success, NSString *des) {
            if (success) {
                KPostNotification(KNotificationAutoLoginSuccess, nil);
            } else {
                [MBProgressHUD showErrorMessage:NSStringFormat(@"登录失败:%@", des)];
            }
        }];
    } else { //无缓存的用户数据
        KPostNotification(KNotificationLoginStateChange, @NO);
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
    BOOL isNetWork = [notification.object boolValue];
    if (isNetWork) { //有网络
        if ([userManager loadUserInfo] && !isLogin) { //有用户数据并且未登陆成功
            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
                if (success) {
                    KPostNotification(KNotificationAutoLoginSuccess, nil);
                } else {
                    [MBProgressHUD showErrorMessage:NSStringFormat(@"登录失败:%@", des)];
                }
            }];
        }
    } else { //登录失败，加载登录页面
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}

#pragma mark - 网络状态监听
- (void)monitorNetworkStatus
{
    [CHHTTPManager networkStatusWithBlock:^(CHNetWorkStatusType status) {
        switch (status) {
            case CHNetWorkStatusUnkonwn: //未知网络
                DLog(@"网络环境：未知网络");
                break;
            case CHNetWorkStatusReachable: //无网络
                DLog(@"网络环境:无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
            case CHNetWorkStatusReachableViaWWAN: //手机网络
                DLog(@"网络环境:手机自带网络");
                break;
            case CHNetWorkStatusReachableViaWiFi: //WiFi
                DLog(@"网络环境:WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 初始化网络配置
//- (void)NetWorkConfig
//{
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = URL_main;
//}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
