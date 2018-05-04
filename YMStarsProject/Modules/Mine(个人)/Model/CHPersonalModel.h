//
//  CHPersonalModel.h
//  Calendar
//
//  Created by huangcanhui on 2017/11/16.
//  Copyright © 2017年 厦门市云梦星辰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHPersonalModel : NSObject
/**
 * 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 * 图片
 */
@property (nonatomic, copy)NSString *icon;
/**
 * 次级标题
 */
@property (nonatomic, copy)NSString *subTitle;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
