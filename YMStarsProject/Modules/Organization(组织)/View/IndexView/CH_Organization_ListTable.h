//
//  CH_Organization_ListTable.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

/**
 * 用来展示机构的一些基本信息
 */
#import <UIKit/UIKit.h>
#import "CHOrganizationModel.h"

@interface CH_Organization_ListTable : UICollectionReusableView
/**
 * 数据源
 */
@property (nonatomic, strong)CHOrganizationModel *object;
/**
 * 选中的回调
 */
@property (nonatomic, copy)void (^tableViewClickIndex) (NSInteger index);

@end

FOUNDATION_EXPORT NSString *CHOrganizationListTableIdentifier;
