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

+ (NSString *)targetString:(NSString *)targetString andStartLocation:(NSInteger)location
{
    NSInteger length = [targetString length];
    if (targetString == nil || [targetString isEqualToString:@""]) {
        return nil;
    } else {
        if (length == 11) { //手机号码
            //截取目标长度的字符串
            NSString *subString = [targetString substringWithRange:NSMakeRange(location, 4)];
            NSString *placeString = [targetString stringByReplacingOccurrencesOfString:subString withString:@"****"];
            return placeString;
        } else if (length >= 15) { //身份证号
            //截取目标长度的字符串
            NSString *subString = [targetString substringWithRange:NSMakeRange(location, 8)];
            NSString *placeString = [targetString stringByReplacingOccurrencesOfString:subString withString:@"********"];
            return placeString;
        } else { //固话
            if ([targetString rangeOfString:@"-"].location != NSNotFound) { //包含区号
                //截取目标长度的字符串
                NSString *subString = [targetString substringWithRange:NSMakeRange(6, 3)];
                NSString *placeString = [targetString stringByReplacingOccurrencesOfString:subString withString:@"***"];
                return placeString;
            } else {//不包含区号
                NSString *subString = [targetString substringWithRange:NSMakeRange(2, 3)];
                NSString *placeString = [targetString stringByReplacingOccurrencesOfString:subString withString:@"***"];
                return placeString;
            }
        }
    }
}

@end
