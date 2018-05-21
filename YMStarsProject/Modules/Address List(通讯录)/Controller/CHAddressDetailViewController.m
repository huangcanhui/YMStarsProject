//
//  CHAddressDetailViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/10.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHAddressDetailViewController.h"

#import "CHHTTPManager.h"
#import "FirendListObject.h"
#import "MJExtension.h"
#import "TelephoneCall.h"

#import "UIViewController+AlertViewAndActionSheet.h"
#import "CHFriend_HeaderView.h"

static NSString *bundleID = @"member_detail";
@interface CHAddressDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *array;
/**
 * 头视图
 */
@property (nonatomic, strong)CHFriend_HeaderView *headerView;
/**
 * 发送信息按钮
 */
@property (nonatomic, strong)UIButton *chatButton;
@end

@implementation CHAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人信息";
    
    [self initUI];
}

- (UIButton *)chatButton
{
    if (!_chatButton) {
        _chatButton = [[UIButton alloc] initWithFrame:CGRectMake(16, kScreenHeight / 2 + 50, kScreenWidth - 32, 45)];
        _chatButton.backgroundColor = CNavBgColor;
        _chatButton.layer.masksToBounds = YES;
        _chatButton.layer.cornerRadius = 5;
        [_chatButton setTitle:@"发送消息" forState:UIControlStateNormal];
        [_chatButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
        [_chatButton addTarget:self action:@selector(chatPeople) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatButton;
}

#pragma mark - 页面视图
- (void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    CHFriend_HeaderView *headerView = [CHFriend_HeaderView headerView];
    headerView.obj = self.obj;
    _headerView = headerView;
    _tableView.tableHeaderView = headerView;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.bounces = NO;
    
    [_tableView addSubview:self.chatButton];
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 45;
    } else {
        return 55;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bundleID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:bundleID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
  
    if (indexPath.section == 0) {
        FirendListObject *list = self.array[indexPath.section];
        if (indexPath.row == 0) { //手机号
            cell.textLabel.text = @"手机号";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (!list.is_accept) { //未被机构接纳
                cell.detailTextLabel.text = [TelephoneCall targetString:list.mobile andStartLocation:3];
            } else {
                cell.detailTextLabel.text = list.mobile;
            }
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"身份证号";
            cell.detailTextLabel.text = [TelephoneCall targetString:list.id_card andStartLocation:5];
        }
    } else {
        cell.textLabel.text = @"个人圈子";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FirendListObject *list = self.array[indexPath.section];
        if (indexPath.row == 0) { //拨打电话
            if (!list.is_accept) {
                [MBProgressHUD showErrorMessage:@"您还不是该机构的成员,无法拨打电话"];
            } else {
                [self AlertWithTitle:@"拨打电话" message:list.mobile andOthers:@[@"取消", @"拨打"] animated:YES action:^(NSInteger index) {
                    if (index == 0) {
                        NSLog(@"取消");
                    } else {
                        [TelephoneCall callTelephoneWithString:list.mobile];
                    }
                }];
            }
        }
    } else {
        //个人圈子
    }
}

#pragma mark - 懒加载
- (NSArray *)array
{
    if (!_array) {
        [[CHHTTPManager manager] requestWithMethod:GET WithPath:[NSString stringWithFormat:@"%@/%@", organ_members_detail_Url, self.obj.id] WithParams:nil WithSuccessBlock:^(NSDictionary *responseObject) {
            FirendListObject *object = [FirendListObject mj_objectWithKeyValues:responseObject[@"data"]];
            _array = @[object];
            [_tableView reloadData];
        } WithFailurBlock:^(NSError *error) {

        }];
    }
    return _array;
}

#pragma mark - 发送信息按钮的点击事件
- (void)chatPeople
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
