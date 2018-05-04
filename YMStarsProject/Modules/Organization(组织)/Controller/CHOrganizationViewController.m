//
//  CHOrganizationViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHOrganizationViewController.h"

#import "CHOrganizationListViewController.h"
#import "CHNavigationController.h"

@interface CHOrganizationViewController ()

@end

@implementation CHOrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([NSString readUserDefaultWithKey:KOrganizationName] != nil) { //即有默认的机构
        NSString *name = [NSString readUserDefaultWithKey:KOrganizationName];
        self.navigationItem.title = [NSString readUserDefaultWithKey:KOrganizationName];
    } else {
        CHOrganizationListViewController *listVC = [CHOrganizationListViewController new];
        CHNavigationController *naVC= [[CHNavigationController alloc] initWithRootViewController:listVC];
        [self presentViewController:naVC animated:NO completion:nil];
    }
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
