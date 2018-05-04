//
//  CHSetUpDetailViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, setupMode) {
    setupWithSecret = 0, //隐私
    setupWithMessage , //新消息通知
    setupWithAdvince, //意见反馈
    setupWithHelp, //帮助中心
    setupWithImage //图片
};

@interface CHSetUpDetailViewController : UIViewController
/**
 * 进入页面的模式
 */
@property (nonatomic, assign)setupMode mode;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *naviItemTitle;
/**
 * 回调
 */
@property (nonatomic, copy)void (^whenClickBack)(NSString *imageMode);
@end
