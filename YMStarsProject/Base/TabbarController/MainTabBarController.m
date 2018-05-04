//
//  MainTabBarController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "MainTabBarController.h"

#import "UITabBar+CH.h"
#import "CHTabBar.h"

#import "CHNavigationController.h"
#import "CHAddressListViewController.h"
#import "CHOrganizationViewController.h"
#import "CHIMListViewController.h"
#import "CHMineViewController.h"


@interface MainTabBarController ()<UITabBarControllerDelegate>
/**
 * 控制器数量
 */
@property (nonatomic,strong) NSMutableArray * VCS;
@end

@implementation MainTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

#pragma mark — 初始化TabBar
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[CHTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

- (void)setUpAllChildViewController
{
     _VCS = @[].mutableCopy;
    
    CHOrganizationViewController *organizationVC = [CHOrganizationViewController new];
    [self setupChildViewController:organizationVC title:@"组织" imageName:@"tab_home" seleceImageName:@"tab_home_select"];
    
    CHAddressListViewController *addressVC = [CHAddressListViewController new];
    [self setupChildViewController:addressVC title:@"通讯录" imageName:@"tab_address" seleceImageName:@"tab_address_select"];
    
    CHIMListViewController *IMVC = [CHIMListViewController new];
    [self setupChildViewController:IMVC title:@"消息" imageName:@"tab_message" seleceImageName:@"tab_message_select"];
    
    CHMineViewController *mineVC = [CHMineViewController new];
    [self setupChildViewController:mineVC title:@"个人中心" imageName:@"tab_mine" seleceImageName:@"tab_mine_select"];
    
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    CHNavigationController *nav = [[CHNavigationController alloc]initWithRootViewController:controller];
    
//        [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
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
