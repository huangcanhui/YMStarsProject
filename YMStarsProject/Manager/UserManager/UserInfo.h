//
//  UserInfo.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/**
 * 省
 */
@property (nonatomic, copy)NSString *province;
/**
 *
 */
@property (nonatomic, strong)NSNumber *notifyCount;
/**
 *
 */
@property (nonatomic, strong)NSNumber *members_count;
/**
 * 昵称
 */
@property (nonatomic, copy)NSString *nickname;
/**
 * 更新时间
 */
@property (nonatomic, copy)NSString *updated_at;
/**
 * 性别
 */
@property (nonatomic, strong)NSNumber *gender;
/**
 * 市
 */
@property (nonatomic, copy)NSString *city;
/**
 *
 */
@property (nonatomic, strong)NSNumber *reg_org_id;
/**
 * 用户名
 */
@property (nonatomic, copy)NSString *name;
/**
 * 国家
 */
@property (nonatomic, copy)NSString *nation;
/**
 *
 */
@property (nonatomic, strong)NSNumber *ref_user_id;
/**
 * 黑名单
 */
@property (nonatomic, strong)NSArray *black_info;
/**
 * 用户ID
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 性别
 */
@property (nonatomic, copy)NSString *sex;
/**
 * 邮箱
 */
@property (nonatomic, copy)NSString *email;
/**
 * 手机号
 */
@property (nonatomic, copy)NSString *mobile;
/**
 * 头像
 */
@property (nonatomic, copy)NSString *avatar;
/**
 * 区
 */
@property (nonatomic, copy)NSString *county;
/**
 *
 */
@property (nonatomic, strong)NSArray *remark_info;
/**
 * 创建时间
 */
@property (nonatomic, copy)NSString *created_at;
/**
 * 备注
 */
@property (nonatomic, copy)NSString *remark;
@end
