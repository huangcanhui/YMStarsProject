//
//  CH_Organization_Function.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_Organization_Function.h"
#import "Masonry.h"

@implementation CH_Organization_Function

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self createUI];
    }
    return self;
}

- (void)setFunctionName:(NSString *)functionName
{
    _functionName = functionName;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat margin = 8;
    
    UIView *mainView = [UIView new];
    [self addSubview:mainView];
    mainView.backgroundColor = [UIColor whiteColor];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(- 1);
    }];
    
    UILabel *label = [UILabel new];
    label.text = _functionName;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HexColor(0x000000);
    [mainView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mainView);
    }];
}

- (void)createUI
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat margin = 8;
    
    UIView *mainView = [UIView new];
    [self addSubview:mainView];
    mainView.backgroundColor = [UIColor whiteColor];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(- 1);
    }];
    
    UILabel *label = [UILabel new];
    label.text = _functionName;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HexColor(0x000000);
    [mainView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mainView);
    }];
}

@end

const NSString *CHOrganizationFunctionIdentifier = @"CHOrganizationFunction";
