//
//  UIColor+CH.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/8.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CH)
/**
 * UIColor 转UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
