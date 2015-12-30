//
//  GYDShopTableViewController.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDShopTableViewController.h"
#import "GYDShopModel.h"
#import "GYDShopViewCell.h"
#import "GYDGoodViewController.h"

@interface GYDShopTableViewController ()

@property (nonatomic) NSArray *dataSoure;
@property (nonatomic) NSInteger start;
@end

@implementation GYDShopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self customUI];
    [self loadData];
}
- (void)customUI {
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GYDShopViewCell" bundle:nil] forCellReuseIdentifier:@"GYDShopViewCellId"];
    [self customNavidationBar];
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = @"品牌";
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadData {
    if ([self loadDataFromLocal]) {
        [self loadDataFromNet];
    }
}
- (BOOL)loadDataFromLocal {
    return YES;
}
- (void)loadDataFromNet {
    [[NetDataEngine sharedInstance] requsetStoreFrom:[self parseUrl] success:^(id responsData) {
        self.dataSoure = [PaseData paseShopData:responsData];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error");
    }];
}
- (NSString *)parseUrl {
    NSString *str = [NSString stringWithFormat:LCShopUrl,self.start];
    return str;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoure.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GYDShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GYDShopViewCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateWithModel:self.dataSoure[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GYDGoodViewController *goodVC = [[GYDGoodViewController alloc] init];
    GYDShopModel *model = self.dataSoure[indexPath.row];
    goodVC.model_id = model.id;
    [self.navigationController pushViewController:goodVC animated:YES];
}




@end
