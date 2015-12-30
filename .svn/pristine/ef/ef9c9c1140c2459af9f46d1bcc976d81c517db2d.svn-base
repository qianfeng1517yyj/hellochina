//
//  GYDSearchViewController.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDSearchViewController.h"
#import "GYDSearchReusableView.h"
#import "MyWaterLayout.h"
#import "SearchResultViewCell.h"
#import "TalentShowCollectionViewCell.h"
#import "WSProgressHUD.h"
#import "GYDStoreItemViewController.h"
#import "TalentViewController.h"


@interface GYDSearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,MyWaterLayoutDelegate, GYDSearchReusableViewDelegate>
{
    BOOL _isRightButtonClick;
}
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *dataSoure;
@property (nonatomic) GYDSearchReusableView *searchView;

@property (nonatomic) NSString *url;
@property (nonatomic, assign) NSInteger page;


@end

@implementation GYDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor blackColor];
    [self customNavidationBar];
    [self addSearchUI];
    [self setUpCollectionView];
}
- (void)addSearchUI {
    self.searchView = [[GYDSearchReusableView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, 80)];
    self.searchView.delegate = self;
    [self.view addSubview:self.searchView];
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = @"搜索";
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUpCollectionView {
    MyWaterLayout *layout = [[MyWaterLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, LCKScreenWidth, LCKScreenHeight - 64-80) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self registViewForCollection];
    [self.view addSubview:self.collectionView];
}
- (void)registViewForCollection {
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchResultViewCell" bundle:nil] forCellWithReuseIdentifier:@"SearchResultViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TalentShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCellId"];
}
- (void)loadData {
    if (self.url == nil) {
        return;
    }
    [[NetDataEngine sharedInstance] requsetStoreFrom:self.url success:^(id responsData) {
        if (!_isRightButtonClick) {
            self.dataSoure = [PaseData paseSearchGoodData:responsData];
        }else {
            self.dataSoure = [PaseData paseTalentData:responsData];
        }
        if (self.dataSoure.count == 0) {
            [self showMessage:@"没有搜索到结果"];
        }
        [self hiddenMessage];
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (void)showMessage:(NSString *)str {
    [WSProgressHUD showShimmeringString:str maskType:WSProgressHUDMaskTypeBlack maskWithout:WSProgressHUDMaskWithoutNavigation];
}
- (void)hiddenMessage {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
}


#pragma  mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSoure.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isRightButtonClick) {
        SearchResultViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchResultViewCellId" forIndexPath:indexPath];
        [cell updateWithModel:self.dataSoure[indexPath.item]];
        return cell;
    }else {
        TalentShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCellId" forIndexPath:indexPath];
        [cell updateDataWithModel:self.dataSoure[indexPath.item]];
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isRightButtonClick) {
        GYDStoreItemViewController *itemVC = [[GYDStoreItemViewController alloc] init];
        MJYShareModel *model = self.dataSoure[indexPath.item];
        itemVC.goods_id = model.goods_id;
        [self.navigationController pushViewController:itemVC animated:YES];
    }else {
        TalentShowModel *model = self.dataSoure[indexPath.item];
        TalentViewController *talentVC = [[TalentViewController alloc] init];
        talentVC.model = model;
        [self.navigationController pushViewController:talentVC animated:YES];
    }
    
}

#pragma  mark - MyWaterLayoutDelegate
//代理方法计算每一个item的高度
- (CGFloat)waterfallLayout:(MyWaterLayout*)layout heightAtIndexPath:(NSIndexPath*)indexPath {
    if (!_isRightButtonClick) {
        return (LCKScreenWidth-30)/2;
    }
    return 150;
}
- (CGFloat)widthAtSection:(NSInteger)section {
    if (!_isRightButtonClick) {
        return (LCKScreenWidth-30)/2;
    }
    return (LCKScreenWidth-30)/3;
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
    if (!_isRightButtonClick) {
        return 2;
    }
    return 3;
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
    return  CGSizeZero;
}
#pragma  mark - GYDSearchReusableViewDelegate

- (void)searchReusableViewLeftBTClick:(NSString *)message {
    [self showMessage:@"加载中..."];
    _isRightButtonClick = NO;
    NSString *str = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.url = [NSString stringWithFormat:LCSearchGoodsUrl,str,self.page];
    [self.view endEditing:YES];
    [self loadData];
}

- (void)searchReusableViewrightBTClick:(NSString *)message {
    [self showMessage:@"加载中..."];
    _isRightButtonClick = YES;
    NSString *str = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.url = [NSString stringWithFormat:LCSearchUserUrl,str,self.page];
    [self.view endEditing:YES];
    [self loadData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}




@end
