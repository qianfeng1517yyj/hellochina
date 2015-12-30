//
//  CategoryViewController.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "CategoryViewController.h"
#import "WQQCategory.h"
#import "WQQCategoryCollectionViewCell.h"
#import "WQQCollectionViewController.h"

@interface CategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAddData];
    [self createUI];
    [self fetchData];
    
}

- (void)initAddData {
    WQQCategory *commentModel = [[WQQCategory alloc] init];
    commentModel.cat_name = @"我的收藏";
    commentModel.thumb    = @"spec_favour_bg.png";
    [self.dataSource addObject:commentModel];
    WQQCategory *allModel = [[WQQCategory alloc] init];
    allModel.cat_name = @"所有杂志";
    allModel.thumb    = @"spec_all_bg.png";
    [self.dataSource addObject:allModel];
}

#pragma mark - 
#pragma mark 重写父类方法
- (void)createUI {
    CGFloat width = (LCKScreenWidth-45)/2;
    CGFloat height = 115;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(25, 15, 5, 15);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight- 64-70) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = LCBaseMagazineColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"WQQCategoryCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"WQQCategoryCollectionViewCellId"];
    [self.view addSubview:self.collectionView];
    
}
// 网络请求的链接
- (NSString *)composeRequsetUrl {
    return LCMagazineCategoryUrl;
}

// 解析数据
- (void)parsingResponsData:(id)responsData {
    [self.dataSource addObjectsFromArray:[WQQCategory parsingWithRespondData:responsData]];
    [self.collectionView reloadData];
}

#pragma mark - 
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WQQCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WQQCategoryCollectionViewCellId" forIndexPath:indexPath];
    WQQCategory *model = [self.dataSource objectAtIndex:indexPath.row];
    if (indexPath == self.indexPath) {
        cell.isSelected = YES;
    }else {
        cell.isSelected = NO;
    }
    if (indexPath.row < 2) {
        [cell updateWithModel2:model index:indexPath.row];
    }else {
        [cell updateWithModel:model];
    }
    return cell;
}

#pragma mark - 
#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WQQCategoryCollectionViewCell *cell = (WQQCategoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.bgImageView.bounds = CGRectMake(0, 0, 150, 105);
    WQQCategory *model = [self.dataSource objectAtIndex:indexPath.row];
    if(indexPath.row == 1) {
        if ([self.delegate respondsToSelector:@selector(goBack:title:indexPath:)]) {
            [self.delegate goBack:[NSString stringWithFormat:LCMagazineUrl] title:nil indexPath:indexPath];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(goBack:title:indexPath:)]) {
            [self.delegate goBack:[NSString stringWithFormat:LCMagazineCategoryGoBackUrl,model.cat_id] title:model.cat_name indexPath:indexPath];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == self.indexPath) {
        return CGSizeMake((LCKScreenWidth-45)/2, 115);
    }else {
        return CGSizeMake((LCKScreenWidth-45)/2, 115);
    }
}


@end
