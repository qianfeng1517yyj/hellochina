//
//  GYDStoreItemViewController.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDStoreItemViewController.h"
#import "MyWaterLayout.h"
#import "GYDItemoModel.h"
#import "GYDFirstCollectionViewCell.h"
#import "GYDSecondCollectionViewCell.h"
#import "GYDThirdCollectionViewCell.h"
#import "GYDFourCollectionViewCell.h"
#import "GYDGoodViewController.h"

@interface GYDStoreItemViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,MyWaterLayoutDelegate, GYDFourCollectionViewCellDelegate>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) GYDItemoModel *model;
@end

@implementation GYDStoreItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
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
    self.title = @"产品详情";
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)registViewForCollection {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDFirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDFirstCollectionViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDSecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDSecondCollectionViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDThirdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDThirdCollectionViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDFourCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDFourCollectionViewCellId"];
    
}
- (void)loadData {
    [[NetDataEngine sharedInstance] requsetStoreFrom:[self parseUrl] success:^(id responsData) {
        self.model = [PaseData paseStoreItemDetailData:responsData];
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (NSString *)parseUrl {
    NSString *str = [NSString stringWithFormat:LCStoreItemDetailUrl, self.goods_id];
    return str;
}

#pragma  mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.model!=nil) {
        return 4;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        GYDFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDFirstCollectionViewCellId" forIndexPath:indexPath];
        [cell updateWithModel:self.model];
        return cell;
    }
    if (indexPath.item == 1) {
        GYDSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDSecondCollectionViewCellId" forIndexPath:indexPath];
        [cell updateWithModel:self.model];
        return cell;
    }
    if (indexPath.item == 2) {
        GYDThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDThirdCollectionViewCellId" forIndexPath:indexPath];
        [cell updateWithModel:self.model];
        return cell;
    }
    if (indexPath.item == 3) {
        GYDFourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDFourCollectionViewCellId" forIndexPath:indexPath];
        cell.delegate = self;
        [cell updateWithModel:self.model];
        return cell;
    }
    return nil;
}
#pragma  mark - MyWaterLayoutDelegate
//代理方法计算每一个item的高度
- (CGFloat)waterfallLayout:(MyWaterLayout*)layout heightAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.item == 0) {
        return  415;
    }
    if (indexPath.item == 1) {
        return [GYDSecondCollectionViewCell heightWithModel:self.model];
    }
    if (indexPath.item == 2) {
        return [GYDThirdCollectionViewCell heightWithModel:self.model];
    }
    if (indexPath.item == 3) {
        return [GYDFourCollectionViewCell heightWithModel:self.model];
    }
    return 0;
}
- (CGFloat)widthAtSection:(NSInteger)section {
    return LCKScreenWidth;
}
//有几个区
- (NSInteger)sectionNumber {
    if (self.model == nil) {
        return 0;
    }
    return 1;
}
//每个区有几个
- (NSInteger)numberAtSection:(NSInteger)section {
    return 4;
}
//指定有多少列
- (NSInteger)columNumberAtSection:(NSInteger)section {
    return 1;
}
//指定item之间的间隙
- (CGFloat)interSpaceingAtSection:(NSInteger)section {
    return 0;
}
//指定每一个段的内边距
- (UIEdgeInsets)sectionInsetAtSection:(NSInteger)section {
    return UIEdgeInsetsZero;
}
//每个区的区头的大小
- (CGSize)headderSizeForSection:(NSInteger)section {
    return  CGSizeZero;
}

#pragma mark - GYDFourCollectionViewCellDelegate

- (void)fourCollectionViewDidSelected:(NSString *)model_id {
    GYDGoodViewController *goodVC = [[GYDGoodViewController alloc] init];
    goodVC.model_id = [model_id integerValue];
    [self.navigationController pushViewController:goodVC animated:YES];
}

@end
