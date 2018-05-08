//
//  CH_Organization_ListTable.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/5.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CH_Organization_ListTable.h"

#import "UILabel+CH.h"
#import "CHOrganizationPlistModel.h"
#import "MJExtension.h"

static NSString *listIdentifier = @"cellIdentifier";
@interface CH_Organization_ListTable()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *textArray;
@property (nonatomic, strong)NSArray *dataSource;
/**
 * 介绍
 */
@property (nonatomic, copy)NSString *introduction;
/**
 * 自定义accessoryButton
 */
@property (nonatomic, strong)UIButton *accButton;

@end

@implementation CH_Organization_ListTable

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.bounces = NO;
    tableView.showsVerticalScrollIndicator = NO;
    
    tableView.tableFooterView = [UIView new];
    
    [self addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    } else {
        return [UILabel getHeightByWidth:KScreenWidth - 16 title:self.introduction font:[UIFont systemFontOfSize:16]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    } else {
        return 41;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, view.CH_width, 40)];
        label.backgroundColor = HexColor(0xffffff);
        label.text = @"   介绍:";
        [view addSubview:label];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:listIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0 && indexPath.row == 0) { //通讯录
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if (indexPath.section == 0) {
        CHOrganizationPlistModel *model = self.textArray[indexPath.row];
        cell.textLabel.text = model.title;
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@人", self.dataSource[0]];
        } else {
            cell.detailTextLabel.text = self.dataSource[indexPath.row];
        }
    } else {
        cell.textLabel.text = self.introduction;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIButton *)accButton
{
    if (!_accButton) {
        _accButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
//        [_accButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accButton;
}

- (void)buttonClick:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)btn.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%@", indexPath);
}

- (NSArray *)textArray
{
    if (!_textArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"OrganizationList" ofType:@"plist"];
        NSArray *tempArray = [NSMutableArray arrayWithContentsOfFile:path];
        _textArray = [CHOrganizationPlistModel mj_objectArrayWithKeyValuesArray:tempArray];
    }
    return _textArray;
}

- (void)setObject:(CHOrganizationModel *)object
{
    _object = object;
    if (_object != nil) {
        _dataSource = [NSArray array];
        NSArray *array = [_object.address componentsSeparatedByString:@"省"];
        _dataSource = @[_object.members_count, array[1], _object.owner.nickname, _object.tel];
        _introduction = [NSString string];
        _introduction = _object.introduction;
        [self.tableView reloadData];
    }
}

- (void)dealloc
{
    
}

@end

const NSString *CHOrganizationListTableIdentifier = @"CHOrganizationListTable";
