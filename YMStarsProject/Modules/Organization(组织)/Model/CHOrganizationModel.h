//
//  CHOrganizationModel.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
