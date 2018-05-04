//
//  CHTransition.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTransition : NSObject <UIViewControllerAnimatedTransitioning>
/**
 * 是否是push，反之则是pop
 */
@property (nonatomic, assign)BOOL isPush;
/**
 * 动画时长
 */
@property (nonatomic, assign)NSTimeInterval animationDuration;

@end
