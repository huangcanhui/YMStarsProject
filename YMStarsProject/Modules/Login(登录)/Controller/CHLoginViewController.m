//
//  CHLoginViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHLoginViewController.h"

@interface CHLoginViewController ()

@end

@implementation CHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"登录";
    
    YYLabel *snowBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, 200, 150, 60)];
    snowBtn.text = @"登录";
    snowBtn.font = SYSTEMFONT(20);
    snowBtn.textColor = KWhiteColor;
    snowBtn.backgroundColor = CNavBgColor;
    snowBtn.textAlignment = NSTextAlignmentCenter;
    snowBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    snowBtn.centerX = KScreenWidth/2;
    kWeakSelf(self);
    snowBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakself WXLogin];
    };
    
    [self.view addSubview:snowBtn];
}

- (void)WXLogin
{
    NSDictionary *params = @{
                             @"userName":@"ymstars",
                             @"password":@"111111"
                             };
    [userManager login:kUserLoginTypePwd params:params completion:^(BOOL success, NSString *des) {
        if (success) {
            DLog(@"成功");
        } else {
            DLog(@"失败");
        }
    }];
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
