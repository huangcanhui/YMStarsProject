//
//  CHSocial_FriendController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHSocial_FriendController.h"

#import "PublishSocialViewController.h"

#import "SocialMenuButton.h"
#import "CHBarButtonItem.h"

@interface CHSocial_FriendController ()
/**
 * UIScrollView
 */
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation CHSocial_FriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"圈子";
    
    self.array = @[@"全部", @"新鲜事", @"活动", @"失物招领", @"遗失登记", @"出行"];
    
    [self.view addSubview:self.scrollView];
    
    [self initSocialMenuButton];
    
    CHBarButtonItem *addButton = [[CHBarButtonItem alloc] initContainImage:[UIImage imageNamed:@"add"] imageViewFrame:CGRectMake(0, 0, 20, 20) buttonTitle:nil titleColor:nil titleFrame:CGRectZero buttonFrame:CGRectMake(0, 0, 25, 25) target:self action:@selector(showPublicController:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth / 3 * self.array.count, 50);
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

#pragma mark - 添加按钮
- (void)initSocialMenuButton
{
    CGFloat buttonW = (kScreenWidth - 3) / 3;
    for (int i = 0; i < self.array.count; i++) {
        SocialMenuButton *button = [SocialMenuButton buttonwWithFrame:CGRectMake((buttonW + 1) * i, 1, buttonW, 48) type:UIButtonTypeCustom andFont:15 backgroundColor:[UIColor groupTableViewBackgroundColor] selectGroundColor:[UIColor lightTextColor] andTitle:self.array[i] andTitleColor:HexColor(0x000000) selectTitleColor:HexColor(0xffffff) andTmepBlock:^(SocialMenuButton *button) {
            [self getSocialoOfFriendsListWithTagID:button.tag];
            for (UIView *view in _scrollView.subviews) {
                if ([view isKindOfClass:[SocialMenuButton class]]) {
                    if (view.tag == button.tag) {
                        ((SocialMenuButton *)view).selected = YES;
                        ((SocialMenuButton *)view).backgroundColor = CNavBgColor;
                    } else {
                        ((SocialMenuButton *)view).selected = NO;
                        ((SocialMenuButton *)view).backgroundColor = [UIColor groupTableViewBackgroundColor];
                    }
                }
            }
        }];
        button.tag = 100 + i;
        if (button.tag == 100) { //默认选中
            button.selected = YES;
            button.backgroundColor = CNavBgColor;
            [self getSocialoOfFriendsListWithTagID:button.tag];
        }
        [self.scrollView addSubview:button];
    }
}

#pragma mark - 各种点击事件
#pragma mark 社交模块选择
- (void)getSocialoOfFriendsListWithTagID:(NSInteger)tag
{
    NSLog(@"%ld", (long)tag);
}

#pragma mark 右上角的点击事件
- (void)showPublicController:(UIButton *)btn
{
    PublishSocialViewController *publishVC = [PublishSocialViewController new];
    CHNavigationController *naVC = [[CHNavigationController alloc] initWithRootViewController:publishVC];
    [self presentViewController:naVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
