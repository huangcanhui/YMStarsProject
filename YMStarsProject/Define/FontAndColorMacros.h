//
//  FontAndColorMacros.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark - 间距区
//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区
//主题色 导航栏颜色
// rgb颜色转换（16进制->10进制）
#define HexColor(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
#define CNavBgColor  HexColor(0x00AE68)

#define CNavBgFontColor  HexColor(0xffffff)

//默认页面背景色
#define CViewBgColor HexColor(0xf2f2f2)

//分割线颜色
#define CLineColor HexColor(0xededed)

//次级字色
#define CFontColor1 HexColor(0x1f1f1f)

//再次级字色
#define CFontColor2 HexColor(0x5c5c5c)

#pragma mark -  字体区


#define FFont1 [UIFont systemFontOfSize:12.0f]

#endif /* FontAndColorMacros_h */
