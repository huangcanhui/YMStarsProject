//
//  CHNavigationController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHNavigationController.h"

@interface CHNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
/**
 * 添加滑动手势
 */
@property (nonatomic, strong)UIPercentDrivenInteractiveTransition *interactivePopTransition;
/**
 * 是否开启系统右划返回
 */
@property (nonatomic, assign)BOOL isSystemSlidBack;
/**
 * 全屏滑动返回
 */
@property (nonatomic, strong)UIScreenEdgePanGestureRecognizer *popRecognizer;
@end

@implementation CHNavigationController

//APP声明周期中，只会执行一次
+ (void)initialize
{
    //导航栏主题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景色
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgFontColor, NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]]; //去掉阴影线
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}

/**
 * 解决手势失效问题
 */
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    } else {
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

/**
 * 根视图禁用右划返回
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count == 1 ? NO : YES;
}

/**
 * push时隐藏tabbar
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = NO;
    } else {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    //修改tabbar的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[CHRootViewController class]]) {
        CHRootViewController *vc = (CHRootViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            vc.view.top = kTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

- (BOOL)popToAppPointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if (vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    return nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (!self.interactivePopTransition) {
        return nil;
    }
    return self.interactivePopTransition;
}

#pragma mark 滑动事件
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
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
