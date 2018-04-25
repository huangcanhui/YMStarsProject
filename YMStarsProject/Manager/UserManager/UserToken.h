//
//  UserToken.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserToken : NSObject
/**
 * 用户token
 */
@property (nonatomic, copy)NSString *access_token;
/**
 * token类型
 */
@property (nonatomic, copy)NSString *token_type;
/**
 * refresh_token过期时间
 */
@property (nonatomic, copy)NSString *expires_in;
/**
 * 刷新token
 */
@property (nonatomic, copy)NSString *refresh_token;

@end
