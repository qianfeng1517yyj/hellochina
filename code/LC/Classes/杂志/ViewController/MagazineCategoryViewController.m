//
//  MagazineCategoryViewController.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MagazineCategoryViewController.h"

@interface MagazineCategoryViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@property (weak, nonatomic) IBOutlet UIImageView *CategoryImageView;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UIScrollView *interfaceScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *titleViewScrollView;

@property (nonatomic) UITableView *tabelView;
@property (nonatomic) UICollectionView *collectView;


@end

@implementation MagazineCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

#pragma mark -
- (void)createInterfaceScrollViewAddTabelView {
    self.interfaceScrollView.contentSize = CGSizeMake(LCKScreenWidth*2,0);
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(LCKScreenWidth, 0, LCKScreenWidth, self.interfaceScrollView.height)];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    
    [self.interfaceScrollView addSubview:self.tabelView];
}

- (void)createInterfaceScrollViewAddCollectionView {
    CGFloat width = (LCKScreenWidth - 60)/2;
    CGFloat height = 160;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(width, height);
    

}



- (IBAction)gobackButtonClick:(id)sender {
}




@end
