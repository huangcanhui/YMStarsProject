//
//  HeaderModel.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/25.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "HeaderModel.h"

@implementation HeaderModel

- (instancetype)init
{
    if (self = [super init]) {
        self.os_type = 2;
        self.version = kApplication.appVersion;
        self.channel = @"App Store";
        self.clientId = @"0";//这边统一标识成0.后期需要，需去获取IMEI号
        self.versioncode = KVersionCode;
        self.mobile_model = [UIDevice currentDevice].machineModelName;
        self.mobile_brand = [UIDevice currentDevice].machineModel;
    }
    return self;
}

@end
