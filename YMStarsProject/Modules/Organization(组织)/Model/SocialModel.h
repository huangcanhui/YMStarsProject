//
//  SocialModel.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialModel : NSObject
/**
 * id
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 图片
 */
@property (nonatomic, copy)NSString *icon;
/**
 * 标识
 */
@property (nonatomic, copy)NSString *sign;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 名称
 */
@property (nonatomic, copy)NSString *name;
/**
 * 是否需要开通
 */
@property (nonatomic, assign)BOOL need_check;
@end
