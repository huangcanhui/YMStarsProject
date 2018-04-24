//
//  AppDelegate.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

/**
 * 这里只做调用，具体实现放到AppDelegate+AppService或者manager里面，防止代码过多不清晰
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * 主控制器
 */
@property (nonatomic, strong) MainTabBarController *mainTabbar;
@end

