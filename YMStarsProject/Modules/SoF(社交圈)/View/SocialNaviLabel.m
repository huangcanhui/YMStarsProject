//
//  SocialNaviLabel.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "SocialNaviLabel.h"

@interface SocialNaviLabel()
/**
 * UILabel
 */
@property (nonatomic, strong)UILabel *label;
@end

@implementation SocialNaviLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI:frame];
    }
    return self;
}

- (void)initUI:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor =HexColor(0xffffff);
    self.label = label;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:label];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    //创建一个富文本
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"arrow_down_white"];
    attach.bounds = CGRectMake(2, 0, 12, 12);
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:_title];
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attach];
    [attributeString appendAttributedString:string];
    self.label.attributedText = attributeString;
}

@end
