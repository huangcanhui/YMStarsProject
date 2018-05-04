//
//  CHShareManager.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

//分享的相关服务
#import <Foundation/Foundation.h>

@interface CHShareManager : NSObject
//单例
SINGLETON_FOR_HEADER(CHShareManager)
/**
 * 这是分享功能的封装
 * @param vc 从什么页面跳转进入的
 * @param title 分享的标题
 * @param content 分享的内容
 * @param url 分享的网址
 */
+ (void)shareToFriendsViewController:(UIViewController *)vc withTitle:(NSString *)title content:(NSString *)content withUrl:(NSString *)url;
/**
 * 这是分享下载的地址，暂时还没有上线，预留
 */
+ (NSString *)shareAPPDownloadUrl;
@end
