//
//  TypeListViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialModel.h"

@interface TypeListViewController : UIViewController
/**
 * NSArray
 */
@property (nonatomic, strong)NSArray *list;
/**
 * 回调
 */
@property (nonatomic, copy)void (^backPublishVC)(SocialModel *model);
@end
