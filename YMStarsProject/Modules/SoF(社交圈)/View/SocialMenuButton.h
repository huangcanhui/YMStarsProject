//
//  SocialMenuButton.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialMenuButton;

typedef void (^socialMenuBlock)(SocialMenuButton *button);

@interface SocialMenuButton : UIButton

@property (nonatomic, copy)socialMenuBlock block;

/**
 * 这是一个按钮的封装
 * @params frame 图片的大小
 * @params type 按钮的类型
 * @params font 文字的大小
 * @params backColor 背景色
 * @params selectBackColor 选中的背景色
 * @params title 文字内容
 * @params color 文字颜色
 * @params selectTitleColor 选中的文字颜色
 * @params block 回调
 **/
+ (SocialMenuButton *)buttonwWithFrame:(CGRect)frame type:(UIButtonType)type andFont:(int)font backgroundColor:(UIColor *)backColor selectGroundColor:(UIColor *)selectBackColor andTitle:(NSString *)title andTitleColor:(UIColor *)color selectTitleColor:(UIColor *)selectTitleColor andTmepBlock:(socialMenuBlock)block;

@end
