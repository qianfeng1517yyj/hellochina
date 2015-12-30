//
//  GYDStoreDetailViewController.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDStoreDetailViewController.h"
#import "GYDDetailCollectionViewCell.h"
#import "MyWaterLayout.h"
#import "GYDDetailHeadView.h"
#import "GYDStoreItemViewController.h"

#define url1 @"http://app.iliangcang.com/goods/class?coverId=%@&orderby=price&min=%ld&max=%ld&app_key=Android&build=2015092501&count=20&page=%ld&self_host=1&v=1.0"
#define url2 @"http://app.iliangcang.com/goods/class?coverId=%@&orderby=price&min=%ld&app_key=iphone&build=2015092501&count=20&page=%ld&self_host=1&v=1.0"

@interface GYDStoreDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,MyWaterLayoutDelegate, GYDDetailHeadViewDelegate, UIScrollViewDelegate>
{
    NSInteger _minPrice;
    NSInteger _maxPrice;
}
@property(nonatomic)BOOL isRefreshing;
@property(nonatomic)BOOL isLoadingMore;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *dataSoure;



@end

@implementation GYDStoreDetailViewController

- (instancetype)init {
    if (self = [super init]) {
        self.url = LCStoreDetailUrl;
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self setUptHeadRefreshView];
    [self setUpFootRefreshView];
    [self registViewForCollection];
    [self.view addSubview:self.collectionView];
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    if (self.superModel.name != nil) {
        self.title = self.superModel.name;
    }
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registViewForCollection {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GYDDetailCollectionViewCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GYDDetailHeadView" bundle:nil] forSupplementaryViewOfKind:MyWaterLayoutKindSectionHeader withReuseIdentifier:@"GYDDetailHeadViewId"];
}
- (void)loadData {
    [[NetDataEngine sharedInstance] requsetStoreFrom:[self parseUrl] success:^(id responsData) {
        if (self.page == 1) {
            self.dataSoure = [PaseData paseStoreDetailData:responsData];
        }else {
            [self.dataSoure addObjectsFromArray:[PaseData paseStoreDetailData:responsData]];
        }
        [self.collectionView reloadData];
        [self endRefreshing];
    } failed:^(NSError *error) {
        
    }];
}
- (NSString *)parseUrl {
    NSString *str = nil;
    if ([self.url isEqualToString: LCStoreDetailUrl]) {
         str = [NSString stringWithFormat:LCStoreDetailUrl,self.cat_code,self.page];
    }
    if ([self.url isEqualToString:LCStoreOrderByPrice]) {
        str = [NSString stringWithFormat:LCStoreOrderByPrice,self.cat_code,_minPrice,_maxPrice,self.page];
    }
    if ([self.url isEqualToString:LCStoreOrderByMaxPrice]) {
        str = [NSString stringWithFormat:LCStoreOrderByMaxPrice,self.cat_code,_minPrice,self.page];
    }
    if ([self.url isEqualToString:LCStoreHeadDetailUrl]) {
        str = [NSString stringWithFormat:LCStoreHeadDetailUrl,self.cat_code,self.page];
    }
    if ([self.url isEqualToString:url1]) {
        str = [NSString stringWithFormat:url1,self.cat_code,_minPrice,_maxPrice,self.page];
    }
    if ([self.url isEqualToString:url2]) {
        str = [NSString stringWithFormat:url2,self.cat_code,_minPrice,self.page];
    }
    return str;
}
//添加刷新头
- (void)setUptHeadRefreshView {
    __weak typeof(self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf loadData];
    }];
}
//添加刷新尾
- (void)setUpFootRefreshView {
    __weak typeof(self)weakSelf = self;
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore = YES;
        weakSelf.page++;
        [weakSelf loadData];
    }];
}
//结束刷新
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.collectionView footerEndRefreshing];
    }
}

#pragma  mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSoure.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GYDDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GYDDetailCollectionViewCellId" forIndexPath:indexPath];
    GYDStoreDetailModel *model = self.dataSoure[indexPath.item];
    [cell udpateWithModel:model];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    GYDDetailHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GYDDetailHeadViewId" forIndexPath:indexPath];
    headView.delegate = self;
    if (self.childrenModel != nil) {
        [headView udpateWithModel:self.childrenModel];
    }else {
        headView.lineView.hidden = YES;
        headView.nameButton.hidden = YES;
        CGRect frame = headView.priceButton.frame;
        frame.origin.x = 0;
        frame.size.width = LCKScreenWidth;
        headView.priceButton.frame = frame;
    }
    if (self.superModel != nil) {
        headView.superModel = self.superModel;
    }
    headView.bgView = self.view;
    return headView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GYDStoreItemViewController *itemVC = [[GYDStoreItemViewController alloc] init];
    GYDStoreDetailModel *model = self.dataSoure[indexPath.item];
    itemVC.goods_id = model.goods_id;
    [self.navigationController pushViewController:itemVC animated:YES];
}

#pragma  mark - GYDDetailHeadViewDelegate
- (void)detailHeadViewDidSelected:(StoreItemModel *)model{
    self.cat_code = model.code;
    self.childrenModel = model;
    [self loadData];
}
- (void)detailHeadViewPriceSelected:(NSString *)price {
    if ([price isEqualToString:@"全部"]) {
        if (self.isnormal) {
            self.url = LCStoreHeadDetailUrl;
        }else {
            self.url = LCStoreDetailUrl;
        }
        [self loadData];
        return;
    }
    if ([price isEqualToString:@"3000以上"]) {
        if (self.isnormal) {
            self.url = url2;
        }else {
            self.url = LCStoreOrderByMaxPrice;
        }
        _minPrice = 3000;
        [self loadData];
        return;
    }
    if (self.isnormal) {
        self.url = url1;
    }else {
        self.url = LCStoreOrderByPrice;
    }
    NSArray *arr = [price componentsSeparatedByString:@"-"];
    _minPrice = [arr[0] integerValue];
    _maxPrice = [arr[1] integerValue];
    [self loadData];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    UIView *view = [self.view viewWithTag:2000];
    BOOL b = view.isHidden;
    if (!b) {
        view.hidden = YES;
    }
}

#pragma  mark - MyWaterLayoutDelegate
//代理方法计算每一个item的高度
- (CGFloat)waterfallLayout:(MyWaterLayout*)layout heightAtIndexPath:(NSIndexPath*)indexPath {
    return  200*(LCKScreenWidth/320);
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
    return  CGSizeMake(LCKScreenWidth, 40);
}


@end
