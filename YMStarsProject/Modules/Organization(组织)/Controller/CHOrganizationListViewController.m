//
//  CHOrganizationListViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/5/4.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHOrganizationListViewController.h"
#import "CHHTTPManager.h"
#import "CHOrganizationModel.h"
#import "UIImageView+WebCache.h"
#import "CHNetString.h"
#import "UIViewController+CH.h"

static NSString *organizationCell = @"organizationCell";
@interface CHOrganizationListViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *array;
/**
 * 记录选中的机构
 */
@property (nonatomic, assign)NSIndexPath *indexpath;
@end

@implementation CHOrganizationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的机构列表";
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(enterNewOrganizationWithID)];
    
    [self initUI];
}

#pragma mark - 确定按钮
- (void)enterNewOrganizationWithID
{
    CHOrganizationModel *model = self.array[self.indexpath.section];
    [model.id writeUserDefaultWithKey:KOrganizationID];
    [model.simple_name writeUserDefaultWithKey:KOrganizationName];
    if (self.whenClickOrganizationCell) {
        self.whenClickOrganizationCell();
    };
     [self ch_CloseViewController];
}

#pragma mark UITableView.delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:organizationCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:organizationCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == self.indexpath.section) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    CHOrganizationModel *model = _array[indexPath.section];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[CHNetString isValueInNetAddress:model.logo]] placeholderImage:[UIImage imageNamed:@"logo"]];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexpath = indexPath;
    
    [self.tableView reloadData];
}


#pragma mark - 懒加载
- (NSArray *)array
{
    if (!_array) {
        [[CHHTTPManager manager] requestWithMethod:GET WithPath:organ_List_Url WithParams:nil WithSuccessBlock:^(NSDictionary *responseObject) {
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                CHOrganizationModel *model = [CHOrganizationModel modelWithDictionary:dict];
                [arrayM addObject:model];
            }
            _array = [arrayM copy];
            [self.tableView reloadData];
        } WithFailurBlock:^(NSError *error) {
            
        }];
    }
    return _array;
}


#pragma mark - UI
- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:tableView];
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
