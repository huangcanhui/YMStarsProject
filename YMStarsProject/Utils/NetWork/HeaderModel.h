//
//  HeaderModel.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject
/**
 * 当前的APP版本
 */
@property (nonatomic, copy)NSString *version;
/**
 * 客户端的唯一标识，用来判断用户是否更换了设备
 */
@property (nonatomic, copy)NSString *clientId;
/**
 * 来源渠道,苹果使用@“APP Store”
 */
@property (nonatomic, copy)NSString *channel;
/**
 * 手机型号
 */
@property (nonatomic, copy)NSString *mobile_model;
/**
 * 手机品牌
 */
@property (nonatomic, copy)NSString *mobile_brand;
/**
 * 用户登录后分配的token
 */
@property (nonatomic, copy)NSString *token;
/**
 * 操作系统
 */
@property (nonatomic, assign)NSInteger os_type; //0未知，1安卓，2苹果
/**
 * 内部维护的应用版本，随版本递增
 */
@property (nonatomic, assign)NSInteger versioncode;
@end
