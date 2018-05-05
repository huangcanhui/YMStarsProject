//
//  CHOrganizationModel.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FunctionObject;
@class typeObject;

NS_ASSUME_NONNULL_BEGIN

@interface CHOrganizationModel : NSObject
/**
 * 状态
 */
@property (nonatomic, strong)NSNumber *status;
/**
 * 电话号码
 */
@property (nonatomic, copy)NSString *tel;
/**
 * 类型ID
 */
@property (nonatomic, strong)NSNumber *type_id;
/**
 * 机构成员数量
 */
@property (nonatomic, strong)NSNumber *memebers_count;
/**
 * 经度
 */
@property (nonatomic, copy)NSString *lng;
/**
 * 纬度
 */
@property (nonatomic, copy)NSString *lat;
/**
 * 封面
 */
@property (nonatomic, copy)NSString *cover;
/**
 * 标识
 */
@property (nonatomic, copy)NSString *sign;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 地址
 */
@property (nonatomic, copy)NSString *address;
/**
 * 机构名称
 */
@property (nonatomic, copy)NSString *name;
/**
 * 机构简称
 */
@property (nonatomic, copy)NSString *simple_name;
/**
 * 机构图片
 */
@property (nonatomic, copy)NSString *logo;
/**
 * 机构ID
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 已开通的功能
 */
@property (nonatomic, strong)NSArray <FunctionObject *> *functionObjects;
/**
 * 机构的类型
 */
@property (nonatomic, strong)typeObject *type;

@end

#pragma mark 机构开通的功能模块
@interface FunctionObject : NSObject
/**
 * 图片
 */
@property (nonatomic, copy)NSString *icon;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *name;
/**
 * ID
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 标识
 */
@property (nonatomic, copy)NSString *sign;

@end

#pragma mark - 机构的类型
@interface typeObject : NSObject
/**
 * id
 */
@property (nonatomic, strong)NSNumber *id;
/**
 * 名称
 */
@property (nonatomic, copy)NSString *name;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 标识
 */
@property (nonatomic, copy)NSString *sign;
/**
 * 图片
 */
@property (nonatomic, copy)NSString *icon;
@end

NS_ASSUME_NONNULL_END
