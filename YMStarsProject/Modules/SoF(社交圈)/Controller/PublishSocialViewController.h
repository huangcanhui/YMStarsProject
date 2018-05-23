//
//  PublishSocialViewController.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishSocialViewController : UIViewController
/**
 * 选中的ID
 */
@property (nonatomic, strong)NSNumber *ID;
/**
 * 选中的文字
 */
@property (nonatomic, copy)NSString *name;
/**
 * 回调,传回发布的ID，根据ID进行定位
 */
@property (nonatomic, copy)void (^ReloadDataAndUI)(NSNumber *ID);

@end
