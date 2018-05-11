//
//  CHNavigationMapView.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/11.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHNavigationMapView : UIView
/**
 *  从指定地导航到指定地
 */
- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
/**
 *  从目前位置导航到指定地
 */
- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
/**
 * 移除
 */
- (void)remove;

@end
