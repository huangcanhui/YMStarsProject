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
@end

@implementation CHAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人信息";
    
    [self initUI];
}

- (void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bundleID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:bundleID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FirendListObject *list = self.array[indexPath.section];
    if (indexPath.row == 0) { //手机号
        cell.textLabel.text = @"手机号";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!list.is_accept) { //未被机构接纳
            cell.detailTextLabel.text = [TelephoneCall targetString:list.mobile andStartLocation:3];
        } else {
            cell.detailTextLabel.text = list.mobile;
        }
    } else if (indexPath.row == 1) { //身份证号
        cell.textLabel.text = @"身份证号";
        cell.detailTextLabel.text = [TelephoneCall targetString:list.id_card andStartLocation:5];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
}

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
