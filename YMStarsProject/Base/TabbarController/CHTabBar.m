//
//  CHTabBar.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHTabBar.h"

@interface CHTabBar ()
@property (nonatomic, assign)UIEdgeInsets oldSafeAreaInsets;
@end

@implementation CHTabBar

- (void)safeAreaInsetsDidChange
{
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *))
    {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}

@end
