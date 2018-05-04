//
//  CHPersonalDataViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHPersonalDataViewController.h"

#import "CHPersonalData.h"
#import "MJExtension.h"
#import "CHNetString.h"
#import "UIImageView+WebCache.h"
#import "UserInfo.h"

static NSString *cellID = @"PersonalData";
@interface CHPersonalDataViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *data; //这个用来存放plist文件读取到的数据
@property (nonatomic, strong)NSMutableArray *arrayM; //这个用来存放获取到的用户数据
@end

@implementation CHPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"个人信息";
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    [self iniUI];
}

#pragma mark - UI
- (void)iniUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 88;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中的样式
    }
    CHPersonalData *data = _data[indexPath.row];
    cell.textLabel.text = data.title;
    if (indexPath.row == 0 || indexPath.row == 3) {
        UIImageView *imageView = [[UIImageView alloc] init];
        if (indexPath.row == 0) {
            imageView.frame = CGRectMake(kScreenWidth - 100, 10, 60, 60);
            [imageView sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:self.arrayM[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"logo"]];
        } else {
            imageView.frame = CGRectMake(kScreenWidth - 60, 10, 25, 25);
            imageView.image = [UIImage imageNamed:@"personal_scancode"];
        }
        [cell.contentView addSubview:imageView];
    } else {
        cell.detailTextLabel.text = self.arrayM[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载
- (NSArray *)data
{
    if (!_data) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonalData" ofType:@"plist"];
        NSArray *tempArray = [NSMutableArray arrayWithContentsOfFile:path];
        _data = [CHPersonalData mj_objectArrayWithKeyValuesArray:tempArray];
    }
    return _data;
}

- (NSMutableArray *)arrayM
{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
        if (userDic) {
            UserInfo *info = [UserInfo new];
            info = [UserInfo modelWithJSON:userDic];
            [_arrayM addObject:info.avatar];
            [_arrayM addObject:info.nickname];
            [_arrayM addObject:info.mobile];
            [_arrayM addObject:@"lala"];
            [_arrayM addObject:info.remark];
        }
    }
    return _arrayM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
