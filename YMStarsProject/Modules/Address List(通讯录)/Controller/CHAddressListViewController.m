//
//  CHAddressListViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHAddressListViewController.h"

#import "CHHTTPManager.h"
#import "FriendListGroup.h"
#import "FirendListObject.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "CHNetString.h"

static NSString *cellIdentifier = @"IDENTIFIER";
@interface CHAddressListViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * NSArray
 */
@property (nonatomic, strong)NSArray *dataSource;
@end

@implementation CHAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通讯录";
    
    [self initUI];
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendListGroup *group = self.dataSource[section];
    return group.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//右侧的索引数据
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.dataSource valueForKey:@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    FriendListGroup *group = self.dataSource[section];
    return group.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FriendListGroup *group = self.dataSource[indexPath.section];
    FirendListObject *obj = group.list[indexPath.row];
    cell.textLabel.text = obj.real_name;
    for (NSDictionary *dict in obj.ranks) {
        ranks *rank = [ranks mj_objectWithKeyValues:dict];
        if (rank.name != nil) {
            cell.detailTextLabel.text = rank.name;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载
- (NSArray *)dataSource
{
    if (!_dataSource) {
        NSString *path = [NSString stringWithFormat:@"%@/%@/contacts", organ_TelList_Url, [NSNumber readUserDefaultWithKey:KOrganizationID]];
        NSDictionary *params = @{
                               @"include":@"owner.organizations,ranks"
                               };
        [[CHHTTPManager manager] requestWithMethod:GET WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary *responseObject) {
            [self sortByFirstChar:responseObject[@"data"]];
            [self.tableView reloadData];
        } WithFailurBlock:^(NSError *error) {
            
        }];
    }
    return _dataSource;
}

#pragma mark - 本地分类成组
- (void)sortByFirstChar:(NSArray *)array
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (int i = 0; i < array.count; i++) {
        FirendListObject *obj = [FirendListObject mj_objectWithKeyValues:array[i]];
        if (!obj.first_letter) {
            obj.first_letter = @"#";
        }
        NSMutableArray *arrayM = dictM[obj.first_letter];
        if (!arrayM) {
            arrayM = [NSMutableArray array];
            dictM[obj.first_letter] = arrayM;
        }
        [arrayM addObject:obj];
    }
    NSMutableArray *groups = [NSMutableArray array];
    for (int i = 0; i < dictM.allKeys.count; i++) {
        NSString *firstChar = dictM.allKeys[i];
        FriendListGroup *group = [FriendListGroup new];
        group.title = firstChar;
        group.list = dictM[firstChar];
        [groups addObject:group];
    }
    self.dataSource = [self sortArray:groups];
}

#pragma mark - 重新排序
- (NSArray *)sortArray:(NSArray *)data
{
    return [data sortedArrayUsingComparator:^NSComparisonResult(FriendListGroup *obj1, FriendListGroup *obj2) {
        return [obj1.title compare:obj2.title options:NSCaseInsensitiveSearch]; //不区分大小写
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
