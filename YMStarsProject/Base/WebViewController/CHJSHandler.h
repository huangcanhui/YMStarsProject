//
//  CHJSHandler.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

//处理各种js交互

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface CHJSHandler : NSObject

@property (nonatomic, weak, readonly)UIViewController *webVC;
@property (nonatomic, strong, readonly)WKWebViewConfiguration *configuration;

- (instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;

- (void)cancelHandler;

@end
