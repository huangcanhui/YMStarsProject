//
//  FirendListObject.h
//  Calendar
//
//  Created by huangcanhui on 2018/1/3.
//  Copyright © 2018年 厦门市云梦星辰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ranks;

NS_ASSUME_NONNULL_BEGIN

@interface FirendListObject : NSObject
/**
 * ID
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 真实姓名
 */
@property (nonatomic, copy)NSString *real_name;
/**
 * 手机号码
 */
@property (nonatomic, copy)NSString *mobile;
/**
 * 是否入会
 */
@property (nonatomic, assign)BOOL is_accept;
/**
 * 零钱
 */
@property (nonatomic, strong)NSNumber *money;
/**
 * 未知
 */
@property (nonatomic, strong)NSNumber *status;
/**
 * 是否被拉黑
 */
@property (nonatomic, assign)BOOL is_black;
/**
 * 卡号
 */
@property (nonatomic, copy)NSString *card_number;
/**
 * 所属机构ID
 */
@property (nonatomic, strong)NSNumber *org_id;
/**
 * 拼音
 */
@property (nonatomic, copy)NSString *pin_yin;
/**
 * 性别
 */
@property (nonatomic, strong)NSNumber *gender;
/**
 * 身份证号码
 */
@property (nonatomic, copy)NSString *id_card;
/**
 * 职位对象
 */
@property (nonatomic, strong)NSArray *ranks;
/**
 * 首字母
 */
@property (nonatomic, copy)NSString *first_letter;

@end

#pragma mark - 职位的对象
@interface ranks : NSObject
/**
 * ID
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 等级
 */
@property (nonatomic, strong)NSNumber *level;
/**
 * 职位
 */
@property (nonatomic, copy)NSString *name;
/**
 * 头像
 */
@property (nonatomic, copy)NSString *icon;

@end

NS_ASSUME_NONNULL_END
