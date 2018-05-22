//
//  PublishSocialViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "PublishSocialViewController.h"

@interface PublishSocialViewController ()

@end

@implementation PublishSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backSocialFriendVC)];

}

#pragma mark - 返回按钮的点击事件
- (void)backSocialFriendVC
{
    //在这边要进行判断，如果用户已经进行输入的情况
    [self dismissViewControllerAnimated:NO completion:nil];
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
