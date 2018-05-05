//
//  CH_Organization_ADPlayer.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

/**
 * 用来处理机构的封面
 */
#import <UIKit/UIKit.h>

#define ADPlayerH 184.0 //轮播图的高度

@interface CH_Organization_ADPlayer : UICollectionReusableView
/**
 * 网络图片数组
 */
@property (nonatomic, strong)NSArray *urls;
/**
 * 图片的点击事件
 */
@property (nonatomic, copy)void (^ADPlayerClickIndex)(NSInteger index);
@end

FOUNDATION_EXPORT NSString *CHOrganizationADPlayerIdentifier ;
