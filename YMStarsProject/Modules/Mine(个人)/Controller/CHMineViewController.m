//
//  CHMineViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHMineViewController.h"

#import "CHUserView.h"
#import "CHPersonalGroup.h"
#import "CHPersonalModel.h"
#import "CHPersonalTableViewCell.h"
#import "MJExtension.h"

static NSString *cellBundle = @"PERSONAL";
@interface CHMineViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *itemGroups;
/**
 * 头视图
 */
@property (nonatomic, strong)CHUserView *userView;
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation CHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - 视图的创建
- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] init];
    //去除掉横线
    tableView.separatorColor = [UIColor clearColor];
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CHPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:cellBundle];
    //创建登录
    CHUserView *userView = [CHUserView headerView];
    _userView = userView;
    //获取用户的基本信息
    [self getUserData];
    userView.whenUserViewClick = ^{
        [self enterPersonalDataViewController];
    };
    tableView.tableHeaderView = _userView;
    
    [self.view addSubview:tableView];
}

#pragma mark 获取用户的基本信息
- (void)getUserData
{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        _userView.info = [UserInfo modelWithJSON:userDic];
    }
}
#pragma mark  用户的个人资料
- (void)enterPersonalDataViewController
{
    
}

#pragma mark UITableView.delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CHPersonalGroup *group = self.itemGroups[section];
    return group.activity.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemGroups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellBundle];
    if (!cell) {
        cell = [[CHPersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBundle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CHPersonalGroup *group = self.itemGroups[indexPath.section];
    CHPersonalModel *model = group.activity[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载
- (NSArray *)itemGroups
{
    if (!_itemGroups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CHPersonalList" ofType:@"plist"];
        NSArray *tempArray = [NSMutableArray arrayWithContentsOfFile:path];
        _itemGroups = [CHPersonalGroup mj_objectArrayWithKeyValuesArray:tempArray];
    }
    return _itemGroups;
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
