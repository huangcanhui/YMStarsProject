//
//  MainTabBarController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController
/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;
@end
