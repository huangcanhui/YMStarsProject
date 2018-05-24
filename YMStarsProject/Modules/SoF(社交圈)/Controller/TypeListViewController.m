//
//  TypeListViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "TypeListViewController.h"

static NSString *cellID = @"typeList";

@interface TypeListViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 返回按钮
 */
@property (nonatomic, strong)UIButton *backButton;
/**
 * 确定按钮
 */
@property (nonatomic, strong)UIButton *confirmButton;
/**
 * UIView
 */
@property (nonatomic, strong)UIView *naviView;
/**
 * 选中的类型
 */
@property (nonatomic, strong)SocialModel *object;
@end

@implementation TypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布类型";
    
    self.list = @[@"新鲜事", @"活动", @"物品遗失", @"出行", @"互助"];
    
    [self initFalseNavigationBar];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.confirmButton];
}

#pragma mark - 创建一个假的头部
- (void)initFalseNavigationBar
{
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, KScreenWidth - 100, kTopHeight)];
    naviView.backgroundColor = CNavBgColor;
    self.naviView = naviView;
    [naviView addSubview:self.backButton];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(naviView.frame.size.width / 2 - 40, kTopHeight / 2 - 15, 80, 50)];
    label.text = @"选择类型";
    label.textColor = HexColor(0xffffff);
    [naviView addSubview:label];
    [[UIApplication sharedApplication].keyWindow addSubview:naviView];
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, kTopHeight / 2 - 10, 40, 40)];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (void)back:(UIButton *)btn
{
    if (self.backPublishVC) {
        self.backPublishVC(nil);
    }
    [self.naviView removeFromSuperview];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.contentInset = UIEdgeInsetsMake(kTopHeight, 0, 0, 0);
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
//    SocialModel *model = self.list[indexPath.row];
//    cell.textLabel.text = model.name;
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.object = self.list[indexPath.row];
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(8, KScreenHeight - 51, KScreenWidth - 100 - 16, 50)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
        _confirmButton.backgroundColor = CNavBgColor;
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 5;
        [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)confirmButtonClick
{
    if (self.backPublishVC) {
        self.backPublishVC(self.object);
    }
    [self.naviView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
