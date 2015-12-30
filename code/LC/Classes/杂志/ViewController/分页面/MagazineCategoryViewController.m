//
//  MagazineCategoryViewController.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MagazineCategoryViewController.h"
#import "CategoryViewController.h"
#import "AuthorViewController.h"
#import "FetchViewController.h"
#import "WQQCollectionViewController.h"


@interface MagazineCategoryViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FetchViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@property (weak, nonatomic) IBOutlet UIImageView *CategoryImageView;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UIScrollView *titleViewScrollView;
@property (weak, nonatomic) IBOutlet UIButton *pushtitle;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (nonatomic) UICollectionView *collectView;

@property (weak, nonatomic) IBOutlet UIScrollView *bottonScrollView;
@property (nonatomic) UIImageView *animationImageView;

@end

@implementation MagazineCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushtitle.backgroundColor = LCBaseColor;
    self.bottonScrollView.contentSize = CGSizeMake(self.bottonScrollView.width*2-30, 0);
    self.bottonScrollView.contentOffset = CGPointMake(0, 0);
    [self.bottomButton setTitle:self.bottonButtonTitle forState:UIControlStateNormal];
    [self createInterfaceCollectView];
    [self categorybuttonClick];
    [self createAnimationImageView];
}


#pragma mark - 指示动画
- (void)createAnimationImageView {
    self.animationImageView = [[UIImageView alloc] init];
    self.animationImageView.bounds = CGRectMake(0, 0, 6, 5);
    self.animationImageView.center = CGPointMake([WQQHelper heightWithBody:self.bottomButton.currentTitle]/2+LCKScreenWidth/2+10, LCKScreenHeight-self.bottomButton.height/2);
    self.animationImageView.image = [UIImage imageWithOriginal:@"spec_triangle.gif"];
    self.animationImageView.transform = CGAffineTransformMakeRotation(M_PI);
    [self.view addSubview:self.animationImageView];
}

#pragma mark - 
#pragma mark 界面搭建
- (void)createInterfaceCollectView {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing      = 0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.itemSize = CGSizeMake(LCKScreenWidth, LCKScreenHeight-70-64);
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, LCKScreenWidth, LCKScreenHeight-70-64) collectionViewLayout:flowlayout];
    self.collectView.showsHorizontalScrollIndicator = NO;;
    self.collectView.pagingEnabled = YES;
    
    self.collectView.dataSource = self;
    self.collectView.delegate   = self;
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collectView];
}

#pragma mark -
#pragma mark UICollectionViewDataSource 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        CategoryViewController *category = [[CategoryViewController alloc] init];
        category.delegate = self;
        category.indexPath = self.indexPath;
        [cell addSubview:category.view];
        
        [self addChildViewController:category];
        [category willMoveToParentViewController:self];
        return cell;
    }else {
        AuthorViewController *category = [[AuthorViewController alloc] init];
        [cell addSubview:category.view];
        category.delegate = self;
        [self addChildViewController:category];
        [category willMoveToParentViewController:self];
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark UICollectionViewDelegate 代理方法


#pragma mark - 
#pragma mark 视图切换效果
- (void)categorybuttonClick {
    [self.collectView setContentOffset:CGPointMake(0, 0)];
    [self.titleViewScrollView bringSubviewToFront:self.CategoryImageView];
    [self.titleViewScrollView insertSubview:self.authorImageView belowSubview:self.bgView];
    self.categoryButton.selected = YES;
    self.authorButton.selected = NO;
}

- (void)authorbuttonClick {
    [self.collectView setContentOffset:CGPointMake(LCKScreenWidth, 0)];
    [self.titleViewScrollView bringSubviewToFront:self.authorImageView];
    
    [self.titleViewScrollView insertSubview:self.CategoryImageView belowSubview:self.bgView];
    self.categoryButton.selected = NO;
    self.authorButton.selected = YES;

}

#pragma mark - 
#pragma mark 按钮点击事件
- (IBAction)gobackButtonClick:(UIButton *)sender {
    if (sender.tag == 25) {
        [self.bottonScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self categorybuttonClick];
    }
    if (sender.tag == 27) {
        [self.bottonScrollView setContentOffset:CGPointMake(-self.bottonScrollView.width+30, 0) animated:YES];
        [self authorbuttonClick];
    }
    if (sender.tag == 37) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 
#pragma mark FetchViewControllerDelegate
- (void)goBack:(NSString *)url title:(NSString *)title {
    if ([self.delegate respondsToSelector:@selector(goBackMagazineCategoryView:title:)
         ]) {
        [self.delegate goBackMagazineCategoryView:url title:title];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)goBack:(NSString *)url title:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(goBackMagazineCategoryView:title:indexPath:)
         ]) {
        [self.delegate goBackMagazineCategoryView:url title:title indexPath:indexPath];
//        if (indexPath.row == 0) {
//            [self dismissViewControllerAnimated:YES completion:^{
//                WQQCollectionViewController *collection = [[WQQCollectionViewController alloc] init];
//                    collection.delegate = self.delegate;
//                    collection.title = title;
//                    [((UIViewController *)self.delegate).navigationController pushViewController:collection animated:NO];
//                
//                
//            }];
//        }else {
            [self dismissViewControllerAnimated:YES completion:nil];
//        }
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectView) {
        CGPoint collectViewOffset = self.collectView.contentOffset;
        CGFloat bottonSmallViewOffset = self.bottonScrollView.width - 30;
        CGFloat scale = collectViewOffset.x/LCKScreenWidth;
        [self.bottonScrollView setContentOffset:CGPointMake(-scale*bottonSmallViewOffset, 0) animated:YES];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectView) {
        if (scrollView.contentOffset.x/LCKScreenWidth == 0) {
            [self categorybuttonClick];
        }else {
            [self authorbuttonClick];
        }
    }

}








@end
