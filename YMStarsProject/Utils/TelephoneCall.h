//
//  TelephoneCall.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/9.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
//这是一个电话号码的拨打以及号码加密

#import <Foundation/Foundation.h>

@interface TelephoneCall : NSObject
/**
 * 获取电话号码进行拨打
 */
+ (void)callTelephoneWithString:(NSString *)tel;

/**
 * 这是一个用来将电话号码或者身份证号码转变成*号代替的方法
 * @params targetString 要处理的字符串
 * @params location *号开始的位置
 * @return 处理后的字符串长度
 */
+ (NSString *)targetString:(NSString *)targetString andStartLocation:(NSInteger)location;

@end
