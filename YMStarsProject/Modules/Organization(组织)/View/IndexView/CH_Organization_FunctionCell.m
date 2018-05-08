//
//  CH_Organization_FunctionCell.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_Organization_FunctionCell.h"
#import "UIImageView+WebCache.h"
#import "CHNetString.h"

@interface CH_Organization_FunctionCell()
/**
 * 图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *Logo;
/**
 * 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *title;
@end

@implementation CH_Organization_FunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setObject:(FunctionObject *)object
{
    _object = object;
    FunctionObject *obj = [FunctionObject modelWithDictionary:_object];
    [_Logo sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:obj.icon]] placeholderImage:[UIImage imageNamed:@"logo"]];
    _title.text = obj.name;
}

- (void)setModel:(SocialModel *)model
{
    _model = model;
    [_Logo sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:_model.icon]] placeholderImage:[UIImage imageNamed:@"logo"]];
    _Logo.contentMode = UIViewContentModeScaleAspectFit;
    _title.text = _model.name;
}

@end

const NSString *CHOrganizationFunctionCellIndetifier = @"CHOrganizationFunctionCell";
