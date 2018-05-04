//
//  CHPersonalDataViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPersonalDataViewController : UIViewController
/**
 * 回调刷新用户的基本信息
 */
@property (nonatomic, copy)void (^changeUserInfo)(void);

@end
