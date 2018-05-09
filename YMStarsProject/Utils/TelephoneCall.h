//
//  TelephoneCall.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/9.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
//这是一个电话号码的拨打

#import <Foundation/Foundation.h>

@interface TelephoneCall : NSObject
/**
 * 获取电话号码进行拨打
 */
+ (void)callTelephoneWithString:(NSString *)tel;

@end
