//
//  CH_Organization_ADPlayer.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_Organization_ADPlayer.h"
#import "Carousel.h"
#import "CHNetString.h"

@interface CH_Organization_ADPlayer()<CarouselDelegate>
/**
 * 轮播器
 */
@property (nonatomic, strong)Carousel *player;

@end

@implementation CH_Organization_ADPlayer

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.player];
}

- (void)setUrls:(NSArray *)urls
{
    _urls = urls;
    _player = [[Carousel alloc] initWithFrame:self.bounds];
    _player.needPageControl = YES; //是否展示小圆点
    _player.infiniteLoop = YES;
    _player.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_RIGHT;
    _player.contentMode = UIViewContentModeScaleAspectFit;
    _player.delegate = self ;
    _player.placeHolderImageName = @"logo";
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSString *string in _urls) {
        [arrayM addObject:[CHNetString isValueInNetAddress:string]];
    }
    
    self.player.imageUrlArray = arrayM;
     [self addSubview:self.player];
}

- (Carousel *)player
{
    if (!_player) {
        _player = [[Carousel alloc] initWithFrame:self.bounds];
        _player.needPageControl = NO; //是否展示小圆点
        _player.infiniteLoop = YES;
        _player.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_RIGHT;
        _player.contentMode = UIViewContentModeScaleAspectFit;
        _player.delegate = self ;
        _player.placeHolderImageName = @"logo";
    }
    return _player;
}

#pragma mark Carousel.delegate
- (void)tapImageToVCPlayer:(NSInteger)tapCount
{
    if (self.ADPlayerClickIndex) {
        self.ADPlayerClickIndex(tapCount % self.urls.count);
    }
}
@end

const NSString *CHOrganizationADPlayerIdentifier = @"CHOrganizationADPlayer";
