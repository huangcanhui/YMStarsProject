//
//  CHOrganizationListViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHOrganizationListViewController : UIViewController
/**
 * 选中机构的回调
 */
@property (nonatomic, copy)void (^whenClickOrganizationCell)(void);

@end
