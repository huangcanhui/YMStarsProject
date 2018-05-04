//
//  CHUserView.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHUserView.h"
#import "UIImageView+WebCache.h"
#import "CHNetString.h"

@interface CHUserView ()
/**
 * 用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
/**
 * 用户昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *headerName;
/**
 * 点击的手势
 */
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@end

@implementation CHUserView
+ (instancetype)headerView
{
    CHUserView *view = [[[NSBundle mainBundle] loadNibNamed:@"CHUserView" owner:nil options:nil] lastObject];
    //UI
    [view initView];
    
    return view;
}

- (void)initView
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
}

- (void)clickTap:(UITapGestureRecognizer *)tap
{
    if (_whenUserViewClick) {
        _whenUserViewClick();
    }
}

- (void)setInfo:(UserInfo *)info
{
    _info = info;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    //添加手势
    [self addGestureRecognizer:_tap];
    //填充数据
    if (![info.avatar isEqual:@""]) {
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:info.avatar]] placeholderImage:[UIImage imageNamed:@"personal_headLogo"]];
    }
    self.headerName.text = [NSString stringWithFormat:@"您好,%@", info.nickname];
    self.headerName.adjustsFontSizeToFitWidth = YES;
}
@end
