//
//  MagazineViewController.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MagazineViewController.h"
#import "MagazineTableViewCell.h"
#import "WQQMagazineModel.h"
#import "MagazineCategoryViewController.h"
#import "WQQDetailViewController.h"
#import "WQQCollectionViewController.h"

#define LCRowHeight 210  // cell的高
#define LCHeadHeight 40  // 区头的高度
#define LCAnimationImageViewCenterY 22 //指示符号的中心点的高度
#define LCStartHeadHeight 64  // 判断动画开始的高度


@interface MagazineViewController ()<UITableViewDataSource,UITableViewDelegate,MagazineCategoryViewControllerDelegate>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSArray *dataKey;

@property (nonatomic) NSDictionary *dataSource;

@property (nonatomic) UIButton *leftItem;

@property (nonatomic) NSString *url;

@property (nonatomic) UIButton *button;

@property (nonatomic) NSString *bottonButtonTitle;

@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic) UIImageView *animationImageView;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self fetchData];
    [self createNavTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [self.tabBarController.view viewWithTag:10000];
    view.hidden = NO;
}

#pragma mark - 
#pragma mark 创建UI
- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight-LCTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:27/255.0 alpha:1];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UINib *nib = [UINib nibWithNibName:@"MagazineTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MagazineTableViewCellId"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"cellId"];
    [self.view addSubview:self.tableView];
}

#pragma mark - 
#pragma mark 定制Nav
- (void)createNavTitle {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth-20, 44)];
    view.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:27/255.0 alpha:1];
    self.leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftItem.frame = CGRectMake(0, 14, 80, 30);
     [self.leftItem setTintColor:[UIColor whiteColor]];
    [view addSubview:self.leftItem];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"杂志" forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 0, LCKScreenWidth-20, 44);
    self.button.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.button setTintColor:[UIColor whiteColor]];
    [self.button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.animationImageView = [[UIImageView alloc] init];
    self.animationImageView.bounds = CGRectMake(0, 0, 6, 5);
    self.animationImageView.center = CGPointMake([WQQHelper heightWithBody:self.button.currentTitle]/2+LCKScreenWidth/2, LCAnimationImageViewCenterY);
    self.animationImageView.image = [UIImage imageWithOriginal:@"spec_triangle.gif"];
    [view addSubview:self.animationImageView];
    [view addSubview:self.button];
    
    self.navigationItem.titleView = view;
}


- (void)titleButtonClick:(UIButton *)button {
    MagazineCategoryViewController *magzine = [[MagazineCategoryViewController alloc] init];
    magzine.delegate = self;
    magzine.indexPath = self.indexPath;
    magzine.bottonButtonTitle = self.bottonButtonTitle == nil ? @"杂志" : [NSString stringWithFormat:@"杂志·%@",self.bottonButtonTitle];
    [self presentViewController:magzine animated:YES completion:nil];
}

#pragma mark -
#pragma mark 网络请求
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}

- (BOOL)fetchDataFromLocal {
    return NO;
}

- (void)fetchDataFromServer {
    NSString *url = [self composeRequsetUrl];
    [[NetDataEngine sharedInstance] requsetMagazineFrom:url success:^(id responsData) {
       self.dataKey = [PaseData paseMagazieData:responsData];
       self.dataSource = [PaseData paseMagazineData:responsData];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
    }];
}

- (NSString *)composeRequsetUrl {
    NSString *url = self.url == nil ? LCMagazineUrl : self.url;
    return url;;
}

#pragma mark - 
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataKey.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.dataSource objectForKey:self.dataKey[section]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MagazineTableViewCellId" forIndexPath:indexPath];
     NSArray *array = [self.dataSource objectForKey:self.dataKey[indexPath.section]];
    WQQMagazineModel *model = [array objectAtIndex:indexPath.row];
    [cell updateWithModel:model];
    [self tableViewCellOriginalLocation:cell];
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.dataSource objectForKey:self.dataKey[indexPath.section]];
    WQQMagazineModel *model = [array objectAtIndex:indexPath.row];
    WQQDetailViewController *detail = [[WQQDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LCRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return LCHeadHeight;
    }
    return 22.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cellId"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"cellId"];
    }
    view.contentView.backgroundColor = LCBaseColor;
    NSMutableString *string = [self.dataKey objectAtIndex:section];
    NSString *subTitle = [string substringFromIndex:5];
    UILabel *label = [[UILabel alloc] init];
    if (section == 0) {
        label.frame = CGRectMake(0, 0, LCKScreenWidth, LCHeadHeight);
    }else {
        label.frame = CGRectMake(0, -10, LCKScreenWidth, 25);
    }
    label.text = subTitle;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view.contentView addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headView = (UITableViewHeaderFooterView *)view;
    NSArray *array = [headView.contentView subviews];
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate 代理方法 左上角的滚动显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [self leftHeadAnimation];
    }
    [self interfaceAnimation];
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

// 界面显示动画
- (void)interfaceAnimation {
    MagazineTableViewCell *cell = [[self.tableView visibleCells] firstObject];
   
    if (self.tableView.contentOffset.y >= cell.topY) {
        
        CGFloat height = cell.bottom - self.tableView.contentOffset.y;
        CGFloat scale = 1 - (height / cell.height);
        cell.iconImageView.alpha = 1 - 0.5 *scale;
        cell.iconImageView.frame = CGRectMake(25*scale, LCRowHeight - height, LCKScreenWidth - 50*scale, LCRowHeight);
        cell.layer.masksToBounds = YES;
    }
    if (self.tableView.contentOffset.y >= cell.topY + 70  && self.tableView.contentOffset.y <= cell.bottom-65) {
        CGFloat height = self.tableView.contentOffset.y - cell.topY + 10;
        cell.topic_name.frame = CGRectMake(0, height, LCKScreenWidth, 25);
        cell.cat_name.frame = CGRectMake(0, height+30, LCKScreenWidth, 20);
    }
    if (self.tableView.contentOffset.y < cell.topY) {
        [self tableViewCellOriginalLocation:cell];
    }
    
    if ([self.tableView visibleCells].count >= 2) {
        MagazineTableViewCell *cell1 = [[self.tableView visibleCells] objectAtIndex:1];
        if (self.tableView.contentOffset.y < cell1.topY) {
            [self tableViewCellOriginalLocation:cell1];
        }
    }
    
}

// 初始化cell的位置
- (void)tableViewCellOriginalLocation:(MagazineTableViewCell *)cell {
    cell.iconImageView.frame = CGRectMake(0, 0, LCKScreenWidth, LCRowHeight);
    cell.topic_name.frame = CGRectMake(0, 80, LCKScreenWidth, 25);
    cell.cat_name.frame = CGRectMake(0, 110, LCKScreenWidth, 20);
    cell.iconImageView.alpha = 1;
}

// 左上角滚动显示是效果
- (void)leftHeadAnimation {
    if (self.tableView.contentOffset.y<LCHeadHeight) {
        [self.leftItem setTitle:nil forState:UIControlStateNormal];
    }else if (self.tableView.contentOffset.y >= LCHeadHeight){
        NSIndexPath *indexPath =  [[self.tableView indexPathsForVisibleRows] firstObject];
        [self.leftItem setTitle:[self getNeedString:self.dataKey[indexPath.section]] forState:UIControlStateNormal];
    }
}

// 获取需要的字符串
- (NSString *)getNeedString:(NSString *)string{
    NSString *subTitle = [string substringFromIndex:5];
    return subTitle;
}


#pragma mark -
#pragma mark MagazineCategoryViewControllerDelegate 代理方法
- (void)goBackMagazineCategoryView:(NSString *)url title:(NSString *)title {
    [self.button setTitle:[NSString stringWithFormat:@"杂志·%@",title] forState:UIControlStateNormal];
    self.bottonButtonTitle = title;
    self.animationImageView.center = CGPointMake([WQQHelper heightWithBody:self.button.currentTitle]/2+LCKScreenWidth/2, LCAnimationImageViewCenterY);
    self.url = url;
    [self fetchData];
}

// 界面的跳转判断
- (void)goBackMagazineCategoryView:(NSString *)url title:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        WQQCollectionViewController *collection = [[WQQCollectionViewController alloc] init];
        self.bottonButtonTitle = title;
        collection.title = @"杂志·我的收藏";
        [self.navigationController pushViewController:collection animated:YES];
    }
    if (title.length > 0 && ![title isEqualToString:@"我的收藏"]) {
        [self.button setTitle:[NSString stringWithFormat:@"杂志·%@",title] forState:UIControlStateNormal];
        self.bottonButtonTitle = title;
    }else {
        [self.button setTitle:@"杂志" forState:UIControlStateNormal];
        self.bottonButtonTitle = title;
    }
    self.animationImageView.center = CGPointMake([WQQHelper heightWithBody:self.button.currentTitle]/2+LCKScreenWidth/2, LCAnimationImageViewCenterY);
    self.url = url;
    self.indexPath = indexPath;
    [self fetchData];
}
@end
