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
static NSString *test = @"1月7日，厦门市泉州商会精准扶贫2017年第一次工作会议在安溪县桃舟乡下格村村委会召开。";

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
    self.tableView.tableFooterView = [UIView new];
    
    [self addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:listIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) { //通讯录
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) { //地址
            _accButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
            [self.accButton setImage:[UIImage imageNamed:@"Organ_Annotation"] forState:UIControlStateNormal];
            [_accButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = self.accButton;
        } else if (indexPath.row == 3) { //联系方式
            _accButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
            [self.accButton setImage:[UIImage imageNamed:@"Organ_Tel"] forState:UIControlStateNormal];
            [_accButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = self.accButton;
        }
    }
    CHOrganizationPlistModel *model = self.textArray[indexPath.row];
    cell.textLabel.text = model.title;
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@人", self.dataSource[0]];
    } else {
        cell.detailTextLabel.text = self.dataSource[indexPath.row];
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) { //联系人
        [self getOrganizationMessage:indexPath];
    }
}

- (void)buttonClick:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)btn.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self getOrganizationMessage:indexPath];
}

#pragma mark - 获取了点击事件
- (void)getOrganizationMessage:(NSIndexPath *)indexPath
{
    if (self.tableViewClickIndex) {
        self.tableViewClickIndex(indexPath);
    }
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
        [self.tableView reloadData];
    }
}

- (void)dealloc
{
    
}

@end

const NSString *CHOrganizationListTableIdentifier = @"CHOrganizationListTable";
