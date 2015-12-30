//
//  GYDGoodViewController.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDGoodViewController.h"
#import "MyWaterLayout.h"
#import "GYDGoodViewCell.h"
#import "GYDGoodHeadView.h"
#import "WSProgressHUD.h"
#import "GYDStoreItemViewController.h"

@interface GYDGoodViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, MyWaterLayoutDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *dataSoure;
@property (nonatomic, strong) NSMutableDictionary *headDataSoure;

@end

@implementation GYDGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headDataSoure = [NSMutableDictionary dictionary];
    [self setUpCollectionView];
    [self customNavidationBar];
    [self loadData];
}
- (void)setUpCollectionView {
    MyWaterLayout *layout = [[MyWaterLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self registViewForCollection];
    [self.view addSubview:self.collectionView];
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = @"品牌产品";
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registViewForCollection {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDGoodViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDGoodViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDGoodHeadView" bundle:nil] forSupplementaryViewOfKind:MyWaterLayoutKindSectionHeader withReuseIdentifier:@"GYDGoodHeadViewId"];
}
- (void)loadData {
    [[NetDataEngine sharedInstance] requsetStoreFrom:[self parseUrl] success:^(id responsData) {
        NSDictionary *dic = [(NSDictionary *)responsData objectForKey:@"data"];
        NSDictionary *dic2 = [dic objectForKey:@"logo"];
        [self.headDataSoure setObject:[dic2 objectForKey:@"url"] forKey:@"url"];
        [self.headDataSoure setObject:[dic objectForKey:@"name"] forKey:@"name"];
        self.dataSoure = [PaseData paseShopGoodData:responsData];
        if (self.dataSoure.count == 0 ) {
            [self showMessage];
        }
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (void)showMessage {
    [WSProgressHUD showShimmeringString:@"此品牌暂无商品" maskType:WSProgressHUDMaskTypeBlack maskWithout:WSProgressHUDMaskWithoutNavigation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
}
- (NSString *)parseUrl {
    NSString *str = [NSString stringWithFormat:LCStoreGoodUrl,self.model_id];
    return str;
}


#pragma  mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSoure.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GYDGoodViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDGoodViewCellId" forIndexPath:indexPath];
    [cell updateWithModel:self.dataSoure[indexPath.row]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    GYDGoodHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GYDGoodHeadViewId" forIndexPath:indexPath];
    [headView udpateWithDic:self.headDataSoure];
    return headView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GYDGoodModel *model = self.dataSoure[indexPath.item];
    GYDStoreItemViewController *itemVC = [[GYDStoreItemViewController alloc] init];
    itemVC.goods_id = [NSString stringWithFormat:@"%ld", model.id];
    [self.navigationController pushViewController:itemVC animated:YES];
}

#pragma  mark - MyWaterLayoutDelegate
//代理方法计算每一个item的高度
- (CGFloat)waterfallLayout:(MyWaterLayout*)layout heightAtIndexPath:(NSIndexPath*)indexPath {
    return  230;
}
- (CGFloat)widthAtSection:(NSInteger)section {
    return (LCKScreenWidth - 30)/2;
}
//有几个区
- (NSInteger)sectionNumber {
    return 1;
}
//每个区有几个
- (NSInteger)numberAtSection:(NSInteger)section {
    return self.dataSoure.count;
}
//指定有多少列
- (NSInteger)columNumberAtSection:(NSInteger)section {
    return 2;
}
//指定item之间的间隙
- (CGFloat)interSpaceingAtSection:(NSInteger)section {
    return 10;
}
//指定每一个段的内边距
- (UIEdgeInsets)sectionInsetAtSection:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//每个区的区头的大小
- (CGSize)headderSizeForSection:(NSInteger)section {
    return  CGSizeMake(LCKScreenWidth, 120);
}

@end
