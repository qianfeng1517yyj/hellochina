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

@interface MagazineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSArray *dataKey;

@property (nonatomic) NSDictionary *dataSource;

@property (nonatomic) UILabel *rightItem;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0  blue:arc4random()%256/255.0  alpha:1];
    [self createNavigationRightItem];
    [self createUI];
    [self fetchData];
    [self createNavTitle];
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
- (void)createNavigationRightItem{
    self.rightItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    self.rightItem.tintColor = [UIColor blackColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItem];
    self.navigationItem.leftBarButtonItem = rightItem;
}

- (void)createNavTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, LCKScreenWidth, 44);
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor =  [UIColor colorWithRed:25/255.0 green:25/255.0 blue:27/255.0 alpha:1];
    self.navigationItem.titleView = button;
}

- (void)titleButtonClick:(UIButton *)button {
    [self presentViewController:[[MagazineCategoryViewController alloc] init] animated:YES completion:nil];
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
        NSLog(@"%@",error);
    }];
}
- (NSString *)composeRequsetUrl {
    return LCMagazineUrl;
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
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 22.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cellId"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"cellId"];
    }
    view.contentView.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:27/255.0 alpha:1];
    NSMutableString *string = [self.dataKey objectAtIndex:section];
    NSString *subTitle = [string substringFromIndex:5];
    UILabel *label = [[UILabel alloc] init];
    if (section == 0) {
        label.frame = view.frame;
        self.rightItem.text = subTitle;
    }else {
        label.frame = CGRectMake(0, -10, LCKScreenWidth, 25);
    }
    label.text = subTitle;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view.contentView addSubview:label];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSMutableString *string = [self.dataKey objectAtIndex:section];
    NSString *subTitle = [string substringFromIndex:5];
    self.rightItem.text = subTitle;
    return nil;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headView = (UITableViewHeaderFooterView *)view;
    NSArray *array = [headView.contentView subviews];
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
}



@end
