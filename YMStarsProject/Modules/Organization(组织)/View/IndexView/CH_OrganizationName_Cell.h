//
//  CH_OrganizationName_Cell.h
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHOrganizationModel.h"

@interface CH_OrganizationName_Cell : UICollectionViewCell
/**
 * 数据源
 */
@property (nonatomic, strong)CHOrganizationModel *model;

@end

FOUNDATION_EXPORT NSString *CHOrganizationNameCellIdentifier;
