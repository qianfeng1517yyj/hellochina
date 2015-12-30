//
//  ShareViewController.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "ShareViewController.h"
#import "LCDefine.h"
#import "MJYShareModel.h"
#import "PaseData.h"
#import "MJYShareCollectionViewCell.h"
#import "ShareDetailViewController.h"
#import "GYDSearchViewController.h"
#import "JHRefresh.h"

@interface ShareViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)NSMutableArray *dataSource;
@property (nonatomic)int page;
@property (nonatomic)UICollectionView *collectionView;
@property (nonatomic)UIView *shareView;
@property (nonatomic)UIView *smallView;
@property (nonatomic)BOOL isShow;
@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *classArr;
@property (nonatomic)NSMutableArray *typeArr;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSString *max;
@property (nonatomic)NSString *min;

@property(nonatomic)BOOL isRefreshing;
@property(nonatomic)BOOL isLoadingMore;


@end

@implementation ShareViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [self.tabBarController.view viewWithTag:10000];
    view.hidden = NO;
    [self hiddenSmallView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initData];
    [self customDataSource];
    [self customUIView];
    [self createNagivetionBar];
    [self customCollectionView];
    [self customLeftView];
    [self createTableViewHeadView];
    self.isShow = NO;
    self.smallView.hidden = YES;
    [self createRefreshView];

}
#pragma mark -
#pragma mark NagivetionBar
- (void)createNagivetionBar {
    UIImage *image = [UIImage imageNamed:@"btn_nav_option@2x"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    self.title = @"分享";
    self.navigationItem.leftBarButtonItem = item;
}
- (void)buttonClick {
    
    if (self.isShow == NO) {
        [self showSmallView];
    }
    else {
        [self hiddenSmallView];
    }
    
}
- (void)hiddenSmallView {
    
     self.shareView.frame = CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight);
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.smallView.hidden = YES;
    self.isShow = NO;
}
- (void)showSmallView {
    
    self.shareView.frame = CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.navigationController.navigationBar.frame = CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width, 64);
    self.smallView.hidden = NO;
    self.isShow = YES;
}
- (void)customUIView {
    self.shareView = [[UIView alloc]init];
    self.shareView.frame = CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight - 64);
    [self.view addSubview:self.shareView];
    
}
- (void)customLeftView {
    self.smallView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/2, self.view.frame.size.height-130) style:UITableViewStylePlain];
    self.smallView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCellId"];
    
    [self.smallView addSubview:self.tableView];
    [self.view addSubview:self.smallView];
}
- (void)createTableViewHeadView {

    UIButton *button = [CustomViewFactory createButton:CGRectMake(10, 0, LCKScreenWidth/2-20, 20) title:@"搜索良品" backgourdImage:nil];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;

  
    [button addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
   
    [self.smallView addSubview:button];
    
}
#pragma mark - 刷新
- (void)searchBarClick {
    
    GYDSearchViewController *gydSVC = [[GYDSearchViewController alloc]init];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    [self.navigationController pushViewController:gydSVC animated:YES];
}


- (void)createRefreshView {
    __weak typeof (self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.page = 1;
        [weakSelf customDataSource];
    }];
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadingMore) {
            return ;
        }
        weakSelf.isLoadingMore = YES;
        weakSelf.page ++;
        [weakSelf customDataSource];
    }];
}
- (void)endUpdateing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.collectionView footerEndRefreshing];
    }
    
}
#pragma mark - 请求数据
- (void)initData {
    self.dataSource = [NSMutableArray array];
    self.page = 1;
    self.classArr = [[NSMutableArray alloc]initWithArray:@[@"全部",@"男士",@"女士",@"家居",@"数码",@"工具",@"玩具",@"美容",@"孩子",@"宠物",@"运动",@"饮食",@"文化",@"价格"]];
    self.typeArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MJYShare" ofType:@"plist"];
    NSArray *classNameArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dic in classNameArr) {
        [self.typeArr addObject:dic[@"type"]];
    }

}
- (void)requestDataSourceWith:(NSString *)url {

    [[NetDataEngine sharedInstance]requsetShareFrom:url success:^(id responsData) {
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
            self.dataSource = [PaseData paseShareData:responsData];
        }else {
            [self.dataSource addObjectsFromArray: [PaseData paseShareData:responsData]];
        }
        [self.collectionView reloadData];
       
        [self endUpdateing];
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)customDataSource {
    if (self.index == 14 ) {
       NSString *urlNew = [NSString stringWithFormat:LCShareUrl,self.page];
        [self requestDataSourceWith:urlNew];
    }
    else if(self.index >14&&self.index <=18) {
        NSString *className = self.classArr[self.index];
        NSArray *arr = [className componentsSeparatedByString:@"-"];
        self.max = arr[1];
        self.min = arr[0];
        NSString *urlNew = [NSString stringWithFormat:LCSharePriceUrl,self.max,self.min,self.page];
        [self requestDataSourceWith:urlNew];
    }
    else if(self.index == 19){
        
        NSString *urlNew = [NSString stringWithFormat:LCSharePriceHeighUrl,self.page];
        [self requestDataSourceWith:urlNew];
    }
    else {
     NSString *urlNew = [NSString stringWithFormat:ShareUrl,self.page,self.typeArr[self.index]];
        [self requestDataSourceWith:urlNew];
    }
   
    
}
#pragma mark - 创建CollectionView
- (void)customCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((LCKScreenWidth - 30)/2, (LCKScreenWidth - 30)/2);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight - 64) collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"MJYShareCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cellId"];
    [self.shareView addSubview:self.collectionView];
}
#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJYShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    MJYShareModel *model = self.dataSource[indexPath.row];
    
    [cell updateWith:model];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShow) {
        [self hiddenSmallView];
        self.isShow = NO;
         return;
    }
    ShareDetailViewController *shareDVC = [[ShareDetailViewController alloc]init];
    MJYShareModel *model = self.dataSource[indexPath.row];
    shareDVC.good_id = model.goods_id;
    [self.navigationController pushViewController:shareDVC animated:YES];
    
}
#pragma mark -
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.selectedTextColor = [UIColor greenColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.classArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 13 && self.classArr.count == 14) {
        [self.classArr addObjectsFromArray:@[@"全部",@"0-200",@"201-500",@"501-1000",@"1001-3000",@"3000以上"]];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:19 inSection:indexPath.section]atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    else if(indexPath.row == 13 &&self.classArr.count > 14){
        [self.classArr removeObjectsInRange:NSMakeRange(14, 6)];
        [self.tableView reloadData];
    }

    else {
        self.page = 1;
        self.index = indexPath.row;
        [self customDataSource];
        [self hiddenSmallView];
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:10000];
        view.alpha = 0.01;
    }];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:10000];
        view.alpha = 1.0;
    }];
    
}

@end
