//
//  CHOrganizationViewController.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHOrganizationViewController.h"

#import "CHOrganizationListViewController.h"
#import "CHNavigationController.h"

#import "CH_Organization_ADPlayer.h"
#import "CH_Organization_Function.h"
#import "CH_Organization_ListTable.h"
#import "CH_OrganizationName_Cell.h"
#import "CH_Organization_FunctionCell.h"

#import "CHOrganizationModel.h"
#import "SocialModel.h"
#import "CHHTTPManager.h"
#import "UILabel+CH.h"

@interface CHOrganizationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/**
 * UICollectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 * UICollectionViewFlowLayout
 */
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *dataSource;//开通的功能
@property (nonatomic, strong)NSArray *socialArray; //社交

@end

@implementation CHOrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if ([NSNumber readUserDefaultWithKey:KOrganizationName] != nil) { //即有默认的机构
        self.navigationItem.title = [NSString readUserDefaultWithKey:KOrganizationName];
        [self initCollectionView];
    } else {
        CHOrganizationListViewController *listVC = [CHOrganizationListViewController new];
        CHNavigationController *naVC= [[CHNavigationController alloc] initWithRootViewController:listVC];
        [self presentViewController:naVC animated:NO completion:nil];
    }
}


#pragma mark - 获取机构的基本信息
- (NSArray *)dataSource
{
    if (!_dataSource) {
        kWeakSelf(self);
        NSString *path = [NSString stringWithFormat:@"%@/%@", organ_appoint_Url, [NSNumber readUserDefaultWithKey:KOrganizationID]];
        NSDictionary *params = @{
                                 @"include":@"type,owner,functionObjects"
                                 };
        [[CHHTTPManager manager] requestWithMethod:GET WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary *responseObject) {
            NSMutableArray *arrayM = [NSMutableArray array];
            CHOrganizationModel *model = [CHOrganizationModel modelWithDictionary:responseObject[@"data"]];
            [arrayM addObject:model];
            _dataSource = [arrayM copy];
             [weakself.collectionView reloadData];
        } WithFailurBlock:^(NSError *error) {
            
        }];
    }
    return _dataSource;
}

#pragma mark - 获取机构社交的功能
- (NSArray *)socialArray
{
    if (!_socialArray) {
        kWeakSelf(self);
        [[CHHTTPManager manager] requestWithMethod:GET WithPath:organ_function_Url WithParams:nil WithSuccessBlock:^(NSDictionary *responseObject) {
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                SocialModel *model = [SocialModel modelWithDictionary:dict];
                [arrayM addObject:model];
            }
            _socialArray = [arrayM copy];
            [weakself.collectionView reloadData];
        } WithFailurBlock:^(NSError *error) {
            
        }];
    }
    return _socialArray;
}

#pragma mark - 创建collectionView
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = HexColor(0xffffff);
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight + kNavBarHeight + kStatusBarHeight, 0);
    self.collectionView = collectionView;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"CH_OrganizationName_Cell" bundle:nil] forCellWithReuseIdentifier:CHOrganizationNameCellIdentifier];
    [collectionView registerNib:[UINib nibWithNibName:@"CH_Organization_FunctionCell" bundle:nil] forCellWithReuseIdentifier:CHOrganizationFunctionCellIndetifier];
    
    [collectionView registerClass:[CH_Organization_ADPlayer class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CHOrganizationADPlayerIdentifier];
    [collectionView registerClass:[CH_Organization_Function class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CHOrganizationFunctionIdentifier];
    [collectionView registerClass:[CH_Organization_ListTable class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CHOrganizationListTableIdentifier];
}

#pragma mark UICollectionView.delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section) {
        case 0: //封面
            
            break;
        case 1: // 机构名称
            count = 1;
            break;
        case 2: //功能
        {
            CHOrganizationModel *model = self.dataSource[0];
            count = model.functionObjects.count;
            break;
        }
        case 3: //社交
            count = self.socialArray.count;
            break;
        case 4: //机构的基本信息
            
            break;
        default:
            break;
    }
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat spacing = 0;
    switch (section) {
        case 0: //轮播图
            
            break;
        case 1: //标题
            
            break;
        case 2: //功能
            return 16;
        case 3: //社交
            return 24;
        case 4: //机构的基本信息
            break;
        default:
            break;
    }
    return spacing;
}

/**
 * section的高度
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: //封面
            return CGSizeMake(self.collectionView.CH_width, kRealValue(ADPlayerH));
        case 1: // 机构名称
            
            break;
        case 2: //功能
            return CGSizeMake(self.collectionView.CH_width, 40);
        case 3: //介绍、地址等
            return CGSizeMake(self.collectionView.CH_width, 40);
        case 4: //机构的基本信息
        { CHOrganizationModel *model = self.dataSource[0];
            return CGSizeMake(self.collectionView.CH_width, 40 * 6 + [UILabel getHeightByWidth:self.collectionView.CH_width - 16 title:model.introduction font:[UIFont systemFontOfSize:16]]);
            break;
        }
        default:
            break;
    }
    return CGSizeZero;
}

/**
 * cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: //封面
            
            break;
        case 1: // 机构名称
        {
            CGFloat W = self.collectionView.CH_width;
            CGFloat H = 45;
            return CGSizeMake(W, H);
        }
        case 2: //功能
        {
            CGFloat W = kRealValue(60);
            CGFloat H = W + 40;
            return CGSizeMake(W, H);
        }
        case 3: //社交
        {
            CGFloat W = kRealValue(60);
            CGFloat H = W + 40;
            return CGSizeMake(W, H);
        }
        case 4: //机构的基本信息
        {
            break;
        }
        default:
            break;
    }
    return CGSizeZero;
}

/**
 * 内边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0: //轮播图
            
            break;
        case 1: //名称
            
            break;
        case 2: //功能
            return UIEdgeInsetsMake(10, 0, 0, 10);
        case 3: // 社交
            return UIEdgeInsetsMake(16, 0, 0, 16);
        case 4: //机构的基本信息
            
            break;
        default:
            break;
    }
    return UIEdgeInsetsZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CHOrganizationModel *model = self.dataSource[0];
    if (kind == UICollectionElementKindSectionHeader) {
        switch (indexPath.section) {
            case 0: //封面
            {
                CH_Organization_ADPlayer *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHOrganizationADPlayerIdentifier forIndexPath:indexPath];
                if (model != nil) {
                    header.urls = @[model.cover];
                }
                header.ADPlayerClickIndex = ^(NSInteger index) {
                    NSLog(@"点击了");
                };
                return header;
            }
            case 1: // 机构名称
              
                break;
            case 2: //功能
            {
                CH_Organization_Function *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHOrganizationFunctionIdentifier forIndexPath:indexPath];
                header.functionName = @"已开通的功能";
                return header;
            }
            case 3: //介绍、地址等
            {
                CH_Organization_Function *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHOrganizationFunctionIdentifier forIndexPath:indexPath];
                header.functionName = @"机构社交";
                return header;
            }
            case 4: //机构的基本信息
            {
                CH_Organization_ListTable *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHOrganizationListTableIdentifier forIndexPath:indexPath];
                header.object = model;
                header.tableViewClickIndex = ^(NSInteger index) {
                    NSLog(@"回调");
                };
                return header;
            }
            default:
                break;
        }
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: //封面
            
            break;
        case 1: // 机构名称
        {
            CH_OrganizationName_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHOrganizationNameCellIdentifier forIndexPath:indexPath];
            CHOrganizationModel *model = self.dataSource[0];
            if (model != nil) {
                cell.model = model;
            }
            return cell;
        }
        case 2: //功能
        {
            CH_Organization_FunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHOrganizationFunctionCellIndetifier forIndexPath:indexPath];
            CHOrganizationModel *model = self.dataSource[0];
            if (model != nil) {
                cell.object = model.functionObjects[indexPath.row];
            }
            return cell;
        }
            
        case 3: //社交
        {
            CH_Organization_FunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHOrganizationFunctionCellIndetifier forIndexPath:indexPath];
            SocialModel *model = self.socialArray[indexPath.row];
            if (model != nil) {
                cell.model = model;
            }
            return cell;
        }
            break;
        case 4: //机构的基本信息
            
            break;
        default:
            break;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
