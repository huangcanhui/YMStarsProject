//
//  CHUserView.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface CHUserView : UIView

@property (nonatomic, strong)UserInfo *info;

/**
 * 当用户点击视图的时候
 */
@property (nonatomic, copy)void (^whenUserViewClick)(void);

+ (instancetype)headerView;

@end
