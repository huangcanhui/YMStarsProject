//
//  AppManager.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppManager.h"
#import "CHADPageView.h"
#import "CHBaseWebViewController.h"
#import "CHLoginViewController.h"

@implementation AppManager

+ (void)appStart
{
    //加载广告
    CHADPageView *adView = [[CHADPageView alloc] initWithFrame:kScreen_Bounds withTapBlock:^{
        CHNavigationController *loginNavi = [[CHNavigationController alloc] initWithRootViewController:[[CHBaseWebViewController alloc] initWithUrl:@"http://www.baidu.com"]];
        [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
    }];
    adView = adView;
}

@end
