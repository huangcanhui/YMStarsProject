//
//  RCDRCIMDataSource.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/15.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

#define RCDDataSource [RCDRCIMDataSource shareInstance]

@interface RCDRCIMDataSource : NSObject<RCIMUserInfoDataSource>

+ (RCDRCIMDataSource *)shareInstance;

@end
