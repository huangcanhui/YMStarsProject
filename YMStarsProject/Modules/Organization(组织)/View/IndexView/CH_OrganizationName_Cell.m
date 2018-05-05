//
//  CH_OrganizationName_Cell.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_OrganizationName_Cell.h"
#import "UIImageView+WebCache.h"
#import "CHNetString.h"

@interface CH_OrganizationName_Cell()
/**
 * logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *LOGOView;
/**
 * 机构全称
 */
@property (weak, nonatomic) IBOutlet UILabel *OrganizationName;
@end

@implementation CH_OrganizationName_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CHOrganizationModel *)model
{
    _model = model;
    
    
    [_LOGOView sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:_model.logo]] placeholderImage:[UIImage imageNamed:@"logo"]];
    
    _OrganizationName.text = _model.name;
}

@end

const NSString *CHOrganizationNameCellIdentifier = @"CH_OrganizationName_Cell";
