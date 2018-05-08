//
//  UIImage+CH.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/8.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CH)
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;

@end
