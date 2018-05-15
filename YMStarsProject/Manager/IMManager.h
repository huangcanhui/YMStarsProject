//
//  IMManager.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/15.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/**
 * IM的服务与管理
 */

#import <Foundation/Foundation.h>

typedef void (^loginBlock)(BOOL isSuccess, NSString *des);

@interface IMManager : NSObject

SINGLETON_FOR_HEADER(IMManager);

/**
 * 初始化IM
 */
- (void)initIM;
/**
 * 登录IM
 */
- (void)loginIMCompletion:(loginBlock)completion;
/**
 * 退出IM
 */
- (void)loginOutIM;

@end
