//
//  TelephoneCall.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/9.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "TelephoneCall.h"

@implementation TelephoneCall

+ (void)callTelephoneWithString:(NSString *)tel
{
    NSString *string = [NSString stringWithFormat:@"telprompt://%@", tel];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [kApplication openURL:[NSURL URLWithString:string]];
    });
}

@end
