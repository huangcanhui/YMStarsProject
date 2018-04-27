//
//  CHBaseWebViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

//webview 基类

#import "CHWebViewController.h"

@interface CHBaseWebViewController : CHWebViewController

/**
 * 在多级跳转后，是否返回按钮右侧展示关闭按钮
 */
@property (nonatomic, assign)BOOL isShowCloseBtn;

@end
