//
//  PublishSocialViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "PublishSocialViewController.h"

#import "SocialNaviLabel.h"

#import "TypeListViewController.h"

@interface PublishSocialViewController ()

@end

@implementation PublishSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backSocialFriendVC)];
    
    SocialNaviLabel *label = [[SocialNaviLabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    label.title = @"全部";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTypeList)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tap];
}

#pragma mark - 返回按钮的点击事件
- (void)backSocialFriendVC
{
    //在这边要进行判断，如果用户已经进行输入的情况
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark 类型转换的点击事件
- (void)selectTypeList
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    TypeListViewController *type = [TypeListViewController new];
//    type.backPublishVC = ^(SocialModel) {
//        [backView removeFromSuperview];
//    };
    type.backPublishVC = ^(SocialModel *model) {
        [backView removeFromSuperview];
    };
    type.view.frame = CGRectMake(100, 0, KScreenWidth - 100, KScreenHeight);
    [backView addSubview:type.view];
    [self addChildViewController:type];
}

#pragma mark - 发布的点击事件
- (void)publishCharactor
{
    
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
