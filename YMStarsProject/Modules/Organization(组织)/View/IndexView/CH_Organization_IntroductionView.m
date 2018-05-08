//
//  CH_Organization_IntroductionView.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/8.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_Organization_IntroductionView.h"
#import "UILabel+CH.h"

@interface CH_Organization_IntroductionView()
/**
 * UIView
 */
@property (nonatomic, strong)UIView *view;
@end

@implementation CH_Organization_IntroductionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    [self addSubview:view];
}

- (void)setIntroduction:(NSString *)introduction
{
    _introduction = introduction;
    
    CGFloat H = [UILabel getHeightByWidth:self.view.CH_width - 16 title:_introduction font:[UIFont systemFontOfSize:16]];
    self.view.frame = CGRectMake(0, 0, self.view.CH_width, H);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.CH_width - 16, self.view.CH_height + 20)];
    label.text = [NSString stringWithFormat:@" 介绍:\n %@", _introduction];
    label.backgroundColor = HexColor(0xffffff);
    label.textColor = HexColor(0x000000);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];

}

@end

const NSString *CHOrganizationIntroductionViewIdentifier = @"CHOrganizationIntroductionView";
