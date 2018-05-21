//
//  SocialMenuButton.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "SocialMenuButton.h"

@implementation SocialMenuButton

+ (SocialMenuButton *)buttonwWithFrame:(CGRect)frame type:(UIButtonType)type andFont:(int)font backgroundColor:(UIColor *)backColor selectGroundColor:(UIColor *)selectBackColor andTitle:(NSString *)title andTitleColor:(UIColor *)color selectTitleColor:(UIColor *)selectTitleColor andTmepBlock:(socialMenuBlock)block
{
    SocialMenuButton *button = [SocialMenuButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:selectTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.backgroundColor = backColor;
    [button addTarget:button action:@selector(clickSocialMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    button.block = block;
    return button;
}

- (void)clickSocialMenuButton:(SocialMenuButton *)button
{
    button.block(button);
}

@end
