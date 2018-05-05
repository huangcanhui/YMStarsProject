//
//  CH_Organization_FunctionCell.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHOrganizationModel.h"
#import "SocialModel.h"

@interface CH_Organization_FunctionCell : UICollectionViewCell
/**
 * 数据源
 */
@property (nonatomic, strong)FunctionObject *object; //机构功能
/**
 * 数据源
 */
@property (nonatomic, strong)SocialModel *model; //机构社交

@end

FOUNDATION_EXPORT NSString *CHOrganizationFunctionCellIndetifier;
