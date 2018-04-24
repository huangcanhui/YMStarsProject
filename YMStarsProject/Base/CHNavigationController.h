//
//  CHNavigationController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHNavigationController : UINavigationController
/**
 * 返回到指定的类视图
 *
 * @param ClassName 类名
 * @param animated 是否动画
 */
- (BOOL)popToAppPointViewController:(NSString *)ClassName animated:(BOOL)animated;
@end
